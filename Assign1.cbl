      ******************************************************************
      * Author:     Arthur Scharf
      * Student ID: 040797015
      * Course & Section  CST8283_310
      * Date:  June 4th, 2025
      * Purpose: Writes employee data to a file. Written as an exercise
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ASSIGNMENT-1.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT EMPLOYEE-FILE ASSIGN TO "../employee_data.txt"
              ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
      * File descriptor for Employee File. We'll read and write to this
      * TODO: Make Line Sequential??
       FD  EMPLOYEE-FILE.
       01  EMPLOYEE-FILE-LINE PIC X(55).

       WORKING-STORAGE SECTION.
       01  EMPLOYEE-DETAIL-LINE.
           05  DEPARTMENT-CODE   PIC 999.
           05  LAST-NAME         PIC A(20).
           05  FIRST-NAME        PIC A(20).
           05  YEARS-OF-SERVICE  PIC 99V9.

       01  FLG-LOOPING         PIC A VALUE 'Y'.
      * Used for user control input
       01  CHOICE                PIC A.
       01  EDT-YEARS-OF-SERVICE  PIC 99.9.

       PROCEDURE DIVISION.
      * Opens and closes files, and runs subroutines for read/writing
      * to those files
       100-MAIN-PROCEDURE.
           DISPLAY "---- TAKING INPUT ----"
           PERFORM 200-INIT-WRITE.
           PERFORM 201-TAKE-INPUT UNTIL FLG-LOOPING NOT = 'Y'.
           PERFORM 204-IO-CLEANUP.
           DISPLAY " "
           DISPLAY "---- DISPLAYING RESULTS ----"
           PERFORM 202-INIT-READ.
           PERFORM 203-SHOW-OUTPUT UNTIL FLG-LOOPING = 'N'.
           PERFORM 204-IO-CLEANUP.
           STOP RUN.

      * Inits writing. initializes EMPLOYEE-FILE and sets flag to
      * allow looping input
       200-INIT-WRITE.
           OPEN OUTPUT EMPLOYEE-FILE.
           DISPLAY "-- New Record? (Y/N) --"
           ACCEPT FLG-LOOPING.

      * The body of indefinite loop that takes input form the keyboard
       201-TAKE-INPUT.
           DISPLAY "Enter Deparment Code (999)"
           ACCEPT DEPARTMENT-CODE
           DISPLAY "Enter Last Name"
           ACCEPT LAST-NAME
           DISPLAY "Enter First Name"
           ACCEPT FIRST-NAME
           DISPLAY "Enter Years of Service (99.0)"
           ACCEPT YEARS-OF-SERVICE
           DISPLAY "-- Write? (Y/N) --"
           ACCEPT CHOICE.
           IF CHOICE = 'Y' THEN
              MOVE EMPLOYEE-DETAIL-LINE TO EMPLOYEE-FILE-LINE
              WRITE EMPLOYEE-FILE-LINE.
           DISPLAY "-- New Record? (Y/N) --"
           ACCEPT FLG-LOOPING.

      * Inits reading. Initializes EMPLOYEE-FILE and sets flag if
      * initial data exists
       202-INIT-READ.
           OPEN INPUT EMPLOYEE-FILE.
           MOVE 'Y' TO FLG-LOOPING.
           READ EMPLOYEE-FILE AT END MOVE 'N' TO FLG-LOOPING.

      * The body of a indefinite loop that reads lines from the
      * file and displays the output in a formatted way
       203-SHOW-OUTPUT.
           MOVE YEARS-OF-SERVICE TO EDT-YEARS-OF-SERVICE
           DISPLAY DEPARTMENT-CODE," | ",FIRST-NAME," ",LAST-NAME," | ",
      -       EDT-YEARS-OF-SERVICE
           READ EMPLOYEE-FILE
              AT END MOVE 'N' TO FLG-LOOPING
           END-READ.


       204-IO-CLEANUP.
           CLOSE EMPLOYEE-FILE.

       END PROGRAM ASSIGNMENT-1.
