/* displayRecord.c
 * Display contents of a struct.
 */

#include <stdio.h>
#include "displayRecord.h"

void displayRecord(struct aTag aRecord)
{
  printf("%c, %i, %c\n", aRecord.aChar,
         aRecord.anInt, aRecord.anotherChar);
}

