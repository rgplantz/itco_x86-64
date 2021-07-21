//-------------------------------------------------------------------
//	uart.c
//
//	A character-mode device-driver for the 16550 Serial UART.
//
//	NOTE: Written and tested with Linux kernel module 2.6.26.
//
//	programmer: ALLAN CRUSE
//	written on: 26 AUG 2008
//	revised on: 31 AUG 2008 -- for cables without DTR<-->DSR
//	revised on: 26 OCT 2008 -- to include 'my_poll()' method
//-------------------------------------------------------------------

#include <linux/module.h>	// for init_module() 
#include <linux/proc_fs.h>	// for create_proc_read_entry() 
#include <linux/interrupt.h>	// for request_irq()
#include <linux/poll.h>		// for poll_wait()
#include <asm/uaccess.h>	// for copy_to/from_user()
#include <asm/io.h>		// for inb(), outb()

#define UART_IRQ	4	// UART's Interrupt Request pin
#define UART_BASE	0x03F8	// UART's base I/O port-address
#define INTR_MASK	0x0F	// UART Interrupt Mask

enum	{
	UART_RX_DATA	= UART_BASE + 0,
	UART_TX_DATA	= UART_BASE + 0,
	UART_DLATCH_LO	= UART_BASE + 0,
	UART_DLATCH_HI	= UART_BASE + 1,
	UART_INTR_EN	= UART_BASE + 1,
	UART_INTR_ID	= UART_BASE + 2,
	UART_FIFO_CTRL	= UART_BASE + 2,
	UART_LINE_CTRL	= UART_BASE + 3,
	UART_MODEM_CTRL	= UART_BASE + 4,
	UART_LINE_STAT	= UART_BASE + 5,
	UART_MODEM_STAT = UART_BASE + 6,
	UART_SCRATCH	= UART_BASE + 7,
	};

char modname[] = "uart";
int  my_major = 84;
wait_queue_head_t  wq_recv;
wait_queue_head_t  wq_xmit;


ssize_t my_read( struct file *file, char *buf, size_t len, loff_t *pos ),
my_write( struct file *file, const char *buf, size_t len, loff_t *pos );
unsigned int my_poll( struct file *file, struct poll_table_struct *wait );

struct file_operations	my_fops = {
				owner:	THIS_MODULE,
				write:	my_write,
				read:	my_read,
				poll:	my_poll,
				};

irqreturn_t my_isr( int irq, void *devinfo )
{
	// static int	rep = 0;
	int	interrupt_id = inb( UART_INTR_ID ) & 0x0F;
	if ( interrupt_id & 1 ) return IRQ_NONE;

	// ++rep;
	// printk( "UART %d: interrupt_id=%02X \n", rep, interrupt_id );

	switch ( interrupt_id )
		{
		case 6:	// Receiver Line Status (errors)
			inb( UART_LINE_STAT );
			break;
		case 4:	// Received Data Ready
		case 12: // Character timeout
			wake_up_interruptible( &wq_recv );
			break;
		case 2: // Transmitter Empty 
			wake_up_interruptible( &wq_xmit );
			break;
		case 0:	// Modem Status Changed
			inb( UART_MODEM_STAT );
			break;
		}

	return	IRQ_HANDLED;
}

int my_proc_read( char *buf, char **start, off_t off, int count, 
						 int *eof, void *data ) 
{
	int	interrupt_id = inb( UART_INTR_ID );
	int	line_status = inb( UART_LINE_STAT );
	int	modem_status = inb( UART_MODEM_STAT );
	int	len = 0;
	
	len += sprintf( buf+len, "\n %02X=modem_status  ", modem_status );
	len += sprintf( buf+len, "\n %02X=line_status   ", line_status );
	len += sprintf( buf+len, "\n %02X=interrupt_id  ", interrupt_id );
	len += sprintf( buf+len, "\n\n" );

	return	len;
}


static int __init uart_init( void )
{
	printk( "<1>\nInstalling \'%s\' module\n", modname );

	init_waitqueue_head( &wq_xmit );
	init_waitqueue_head( &wq_recv );

	// configure the UART
	outb( 0x00, UART_INTR_EN );
	outb( 0xC7, UART_FIFO_CTRL );
	outb( 0x83, UART_LINE_CTRL );
	outb( 0x01, UART_DLATCH_LO );
	outb( 0x00, UART_DLATCH_HI );
	outb( 0x03, UART_LINE_CTRL );
	outb( 0x03, UART_MODEM_CTRL );
	inb( UART_MODEM_STAT );
	inb( UART_LINE_STAT );
	inb( UART_RX_DATA );
	inb( UART_INTR_ID );
		
	if ( request_irq( UART_IRQ, my_isr, IRQF_SHARED, 
				modname, &modname ) < 0 ) return -EBUSY;
	outb( INTR_MASK, UART_INTR_EN );
	outb( 0x0B, UART_MODEM_CTRL );
	printk( " Interrupt-ID: %02X \n", inb( UART_INTR_ID ) );

	create_proc_read_entry( modname, 0, NULL, my_proc_read, NULL );
	return	register_chrdev( my_major, modname, &my_fops );
}


static void __exit uart_exit(void )
{
	unregister_chrdev( my_major, modname );
	remove_proc_entry( modname, NULL );

	outb( 0x00, UART_INTR_EN );
	outb( 0x00, UART_MODEM_CTRL );
	free_irq( UART_IRQ, modname );

	printk( "<1>Removing \'%s\' module\n", modname );
}

module_init( uart_init );
module_exit( uart_exit );
MODULE_LICENSE("GPL"); 


ssize_t my_read( struct file *file, char *buf, size_t len, loff_t *pos )
{
	int	count, i, line_status = inb( UART_LINE_STAT );
	
	if ( (line_status & 1) == 0 )
		{
		if ( file->f_flags & O_NONBLOCK ) return 0;
		if ( wait_event_interruptible( wq_recv, 
				(inb( UART_LINE_STAT ) & 1) ) ) return -EINTR;
		}
	
	count = 0;
	for (i = 0; i < len; i++)
		{
		unsigned char	datum = inb( UART_RX_DATA );
		if ( copy_to_user( buf+i, &datum, 1 ) ) return -EFAULT;
		++count;
		if ( (inb( UART_LINE_STAT ) & 1) == 0 ) break;
		}
	
	return	count;
}

ssize_t my_write( struct file *file, const char *buf, size_t len, loff_t *pos )
{
	int	i, count, modem_status = inb( UART_MODEM_STAT );

	if ( (modem_status & 0x10 ) != 0x10 )
		{
		if ( file->f_flags & O_NONBLOCK ) return 0;
		if ( wait_event_interruptible( wq_xmit,
			(inb( UART_MODEM_STAT )&0x10)==0x10 ) ) return -EINTR; 
		}

	count = 0;
	for (i = 0; i < len; i++)
		{
		unsigned char	datum;
		if ( copy_from_user( &datum, buf+i, 1 ) ) return -EFAULT;
		while ( (inb( UART_LINE_STAT ) & 0x20) == 0 ); 
		outb( datum, UART_TX_DATA );
		++count;
		if ( (inb( UART_MODEM_STAT ) & 0x10) != 0x10 ) break; 
		}

	return	count;
}

unsigned int my_poll( struct file *file, struct poll_table_struct *wait )
{
	unsigned int	mask = 0;

	// enqueue the current process in any wait-queues that may 
	// awaken it in the future -- the poll_wait() kernel-function
	// is used for this purpose (Rubini, page 391)
	poll_wait( file, &wq_recv, wait );
	poll_wait( file, &wq_xmit, wait );

	// if read() is ready to return data
	if ( inb( UART_LINE_STAT ) & 0x01 ) mask |= (POLLIN | POLLRDNORM);

	// if write() is ready to accept data
	if ( inb( UART_LINE_STAT ) & 0x20 ) mask |= (POLLOUT | POLLWRNORM);

	return	mask;
}

