      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01  VAR1  PIC 99V9.
       01  VAR2  PIC Z9.9.
       01  FLAG  PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM 101-ACCEPT-AND-DISPLAY UNTIL FLAG = 'Y'.

       101-ACCEPT-AND-DISPLAY.
           ACCEPT VAR1.
           DISPLAY VAR1.

       END PROGRAM YOUR-PROGRAM-NAME.
