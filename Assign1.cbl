      ******************************************************************
      * Author:     Arthur Scharf
      * Student ID: 040797015
      * Course & Section  CST8283_310
      * Date:  June 9th, 2025
      * Purpose: Writes employee data to a file.
      *          Reads and displays employees who've been with the
      *          company for more than 10.5 years.
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
      * NOTE: Could just have defined structure here.
      * Only do this if you have different formatting
       FD  EMPLOYEE-FILE.
       01  EMPLOYEE-FILE-LINE PIC X(55).

      * Struct for employee records
       WORKING-STORAGE SECTION.
       01  EMPLOYEE-RECORD.
           05  EMPLOYEE-ID         PIC 9(6).
           05  DEPARTMENT-CODE     PIC 999.
           05  LAST-NAME           PIC A(20).
           05  FIRST-NAME          PIC A(20).
           05  YEARS-OF-SERVICE    PIC 99V9.

      * Used for formatted display
       01  EMPLOYEE-RECORD-OUT.
           05 EMPLOYEE-ID-OUT      PIC 9(6).
           05 FILLER               PIC X(3)   VALUE SPACES.
           05 DEPARTMENT-CODE-OUT  PIC 999.
           05 FILLER               PIC X(10)  VALUE SPACES.
           05 LAST-NAME-OUT        PIC A(20).
           05 FILLER               PIC X(3)   VALUE SPACES.
           05 FIRST-NAME-OUT       PIC A(20).
           05 FILLER               PIC X(3)   VALUE SPACES.
           05 YEARS-OF-SERVICE-OUT PIC 99.9.

      * Simple header structure used for displaying.
      * I'm getting a warning that the string won't fit in the picture
      * string. The '|' character seems to cause it, yet the program
      * runs properly
       01  HEADERS.
           05 H1 PIC A(9)   VALUE "ID     | ".
           05 H2 PIC A(13)  VALUE "Department | ".
           05 H3 PIC A(23)  VALUE "Last                 | ".
           05 H4 PIC A(23)  VALUE "First                | ".
           05 H5 PIC A(16)  VALUE "Years of Service".

      * Used for display clarity
       01  DASH-LINE PIC X(84) VALUE ALL "=".
      * flag for exiting loop
       01  FLG-LOOPING         PIC A VALUE 'Y'.
      * Used for user control input
       01  CHOICE                PIC A.

      * An explixit decimal was needed for parsing keyboard input for
      * years of service
       01  TEMP-YOS PIC 99.9.


       PROCEDURE DIVISION.
      * Opens and closes files, and runs subroutines for read/writing
      * to those files
       100-MAIN-PROCEDURE.
           DISPLAY "---- TAKING INPUT ----".
           PERFORM 200-INIT-WRITE.
           PERFORM 201-CREATE-EMPLOYEE-RECORD
              UNTIL FLG-LOOPING NOT = 'Y'.
           PERFORM 202-IO-CLEANUP.
           DISPLAY " "
           DISPLAY "---- DISPLAYING RESULTS ----"
           PERFORM 203-INIT-READ.
           DISPLAY DASH-LINE.
           PERFORM 204-READ-EMPLOYEE-RECORD
              UNTIL FLG-LOOPING = 'N'.
           DISPLAY DASH-LINE.
           PERFORM 202-IO-CLEANUP.
           STOP RUN.


      * Inits writing. initializes EMPLOYEE-FILE and sets flag to
      * allow looping input
       200-INIT-WRITE.
           OPEN OUTPUT EMPLOYEE-FILE.
           PERFORM 303-POLL-FOR-CONTINUE.


      * The body of indefinite loop that takes input form the keyboard
       201-CREATE-EMPLOYEE-RECORD.
           PERFORM 302-ACCEPT-INPUT.
           IF CHOICE = 'Y' OR CHOICE = 'y' THEN
              WRITE EMPLOYEE-FILE-LINE FROM EMPLOYEE-RECORD.
           PERFORM 303-POLL-FOR-CONTINUE.


      * Closes the employee file
       202-IO-CLEANUP.
           CLOSE EMPLOYEE-FILE.


      * Inits reading. Initializes EMPLOYEE-FILE and sets flag if
      * initial data exists
       203-INIT-READ.
           OPEN INPUT EMPLOYEE-FILE.
           MOVE 'Y' TO FLG-LOOPING.
           READ EMPLOYEE-FILE AT END MOVE 'N' TO FLG-LOOPING.
           DISPLAY HEADERS.


      * The body of a indefinite loop that reads lines from the
      * file and displays the output in a formatted way
       204-READ-EMPLOYEE-RECORD.
           MOVE EMPLOYEE-FILE-LINE TO EMPLOYEE-RECORD.
           IF YEARS-OF-SERVICE >= 10.5 THEN
                  PERFORM 301-DISPLAY-RECORD.
           READ EMPLOYEE-FILE
              AT END MOVE 'N' TO FLG-LOOPING
           END-READ.




      * Moves data to working-storage and displays it
       301-DISPLAY-RECORD.
           MOVE EMPLOYEE-ID TO EMPLOYEE-ID-OUT
           MOVE DEPARTMENT-CODE TO DEPARTMENT-CODE-OUT
           MOVE LAST-NAME TO LAST-NAME-OUT
           MOVE FIRST-NAME TO FIRST-NAME-OUT
           MOVE YEARS-OF-SERVICE TO YEARS-OF-SERVICE-OUT
           DISPLAY EMPLOYEE-RECORD-OUT.


      * Handles all the input decisions for creating a new record,
      * including the checking if the user wants to create with the
      * data that was entered
       302-ACCEPT-INPUT.
           DISPLAY "Enter Employee ID (999999)".
           ACCEPT EMPLOYEE-ID.
           DISPLAY "Enter Deparment Code (999)".
           ACCEPT DEPARTMENT-CODE.
           DISPLAY "Enter Last Name".
           ACCEPT LAST-NAME.
           DISPLAY "Enter First Name".
           ACCEPT FIRST-NAME.
           DISPLAY "Enter Years of Service (99.9)".
           ACCEPT TEMP-YOS.
           MOVE TEMP-YOS TO YEARS-OF-SERVICE.
           DISPLAY "-- Write? (Y/N) --".
           ACCEPT CHOICE.


      * Polls keyboard for whether we should continue taking input
       303-POLL-FOR-CONTINUE.
           DISPLAY "-- New Record? (Y/N) --".
           ACCEPT FLG-LOOPING.

       END PROGRAM ASSIGNMENT-1.
