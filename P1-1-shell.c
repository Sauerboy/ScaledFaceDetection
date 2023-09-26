//=================================================================
// Copyright 2023 Georgia Tech.  All rights reserved.
// The materials provided by the instructor in this course are for
// the use of the students currently enrolled in the course.
// Copyrighted course materials may not be further disseminated.
// This file must not be made publicly available anywhere.
//=================================================================

/*
Please fill in the following
 Student Name:
 Date:

ECE 2035 Project 1-2

This is the only file that should be modified for the C implementation
of Project 1.

Do not include any additional libraries.
-----------------------------------------------
     Find George Variably Scaled

This routine finds an exact match of George's face which may be
scaled in a crowd of faces.
*/

#include <stdio.h>
#include <stdlib.h>

#define DEBUG 1 // RESET THIS TO 0 BEFORE SUBMITTING YOUR CODE

int Load_Mem(char *, int *);

int main(int argc, char *argv[]) {
   int	             CrowdInts[1024];
   // This allows you to access the pixels (individual bytes)
   // as byte array accesses (e.g., Crowd[25] gives pixel 25):
   char *Crowd = (char *)CrowdInts;
   int	             NumInts, TopLeft, BottomRight;

   if (argc != 2) {
     printf("usage: ./P1-1 valuefile\n");
     exit(1);
   }
   NumInts = Load_Mem(argv[1], CrowdInts);
   if (NumInts != 1024) {
      printf("valuefiles must contain 1024 entries\n");
      exit(1);
   }
   if (DEBUG){
     printf("Crowd[0] is Pixel 0: 0x%02x\n", Crowd[0]);
     printf("Crowd[107] is Pixel 107: 0x%02x\n", Crowd[107]);

     printf("CrowdInts[211] packs 4 Pixels: 0x%08x\n", CrowdInts[211]);
     printf("Crowd[211*4] is Pixel 844: 0x%02x\n", Crowd[844]);
     printf("Crowd[211*4+1] is Pixel 845: 0x%02x\n", Crowd[845]);
     printf("Crowd[211*4+2] is Pixel 846: 0x%02x\n", Crowd[846]);
     printf("Crowd[211*4+3] is Pixel 847: 0x%02x\n", Crowd[847]);
   }
   
   /* your code goes here. */
   TopLeft = 0;        // Temporary: replace this.
   BottomRight = 100;  // Temporary: replace this.
   
   printf("George is located at: top left pixel %4d, bottom right pixel %4d.\n", TopLeft, BottomRight);
   exit(0);
}

/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
      printf("%s could not be opened; check the filename\n", InputFileName);
      return 0;
   } else {
      for (N=0; N < 1024; N++) {
         NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
         if (NumVals == 2)
            IntArray[N] = Value;
         else
            break;
      }
      fclose(FP);
      return N;
   }
}
