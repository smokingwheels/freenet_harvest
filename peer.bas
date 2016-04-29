REM $DYNAMIC
CLEAR 0, 0, 500
CLS
PRINT " Save connections to Strangers page as .txt "
PRINT " Rename file to peers.txt then move to your input location run program"
PRINT " Sort and Randomize "
PRINT " sort uniq sort -R in linux works the fastest "
PRINT " Note: allip.sh must run in Linux with some bandwidth"
PRINT " Put it in a loop and play with the -w 10 -t .003 settings"
REM Adjust Linux path to suit
TIMER ON
ON TIMER(1) GOSUB health
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
INPUT "Key Enter to Process and OVER WRITE Previous File", b$

REM some event trap here


REM Linux
'OPEN "/home/john/Downloads/Freenet/peers.txt" FOR INPUT AS #1 LEN = 30000
'OPEN "/home/john/Downloads/Freenet/connipt.txt" FOR OUTPUT AS #2 LEN = 30000
'OPEN "/home/john/Downloads/Freenet/backipt.txt" FOR OUTPUT AS #3 LEN = 30000

REM Windows
OPEN "e:\qb\Freenet\peers.txt" FOR INPUT AS #1
OPEN "e:\qb\Freenet\connipt.txt" FOR OUTPUT AS #2
OPEN "e:\qb\Freenet\backipt.txt" FOR OUTPUT AS #3

PRINT "User processing Primary and Secondary "

secindex# = 0
priindex# = 0

DO WHILE NOT EOF(1)
    LINE INPUT #1, a$
    IF LEFT$(a$, 9) = "CONNECTED" THEN PRINT #2, a$
    IF LEFT$(a$, 10) = "BACKED OFF" THEN PRINT #3, a$

LOOP
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
REM Linux
'OPEN "/home/john/Downloads/Freenet/connipt.txt" FOR INPUT AS #1
'OPEN "/home/john/Downloads/Freenet/connip.txt" FOR OUTPUT AS #2

REM win
OPEN "e:\qb\Freenet\connipt.txt" FOR INPUT AS #1
OPEN "e:\qb\Freenet\connip.txt" FOR OUTPUT AS #2

GOSUB trapip
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
REM Linux
'OPEN "/home/john/Downloads/Freenet/backipt.txt" FOR INPUT AS #1
'OPEN "/home/john/Downloads/Freenet/backip.txt" FOR OUTPUT AS #2

REM Windows
OPEN "e:\qb\Freenet\backipt.txt" FOR INPUT AS #1
OPEN "e:\qb\Freenet\backip.txt" FOR OUTPUT AS #2

GOSUB trapip
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
GOSUB secip
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
GOSUB postproc
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
PRINT "done"
END

secip:
REM Traps secondary IP's
REM Linux
'OPEN "/home/john/Downloads/Freenet/peers.txt" FOR INPUT AS #1
'OPEN "/home/john/Downloads/Freenet/secip.txt" FOR OUTPUT AS #2
'OPEN "/home/john/Downloads/Freenet/secipt.txt" FOR OUTPUT AS #3


REM Windows
OPEN "e:\qb\Freenet\peers.txt" FOR INPUT AS #1
OPEN "e:\qb\Freenet\secip.txt" FOR OUTPUT AS #2
OPEN "e:\qb\Freenet\secipt.txt" FOR OUTPUT AS #3


DO WHILE NOT EOF(1)
    lenstart = 0
    code$ = ""
    secinput:
    IF NOT EOF(1) THEN LINE INPUT #1, a$
    lineindex# = lineindex# + 1
    lline = LEN(a$)
    code$ = ""
    IF LEFT$(a$, 2) = "/+" THEN GOTO secinput
    IF RIGHT$(a$, 1) = "*" THEN GOTO secinput
    IF RIGHT$(a$, 6) = "window" THEN GOTO secinput
    IF RIGHT$(a$, 3) = " B " THEN GOTO secinput
    IF RIGHT$(a$, 1) = "0s" THEN GOTO secinput
    IF RIGHT$(a$, 2) = "    0" THEN GOTO secinput


    'PRINT LEFT$(a$, 1)


    FOR i = -1 TO lline
        '  code$ = MID$(a$, i + 1, 1)
        code$ = LEFT$(a$, 1)
        '        IF code$ = "/" OR code$ = "*" THEN
        IF code$ = "/" THEN

            k = i + 1
            code$ = MID$(a$, i + 1, 1)
            user$ = ""
            DO
                code$ = MID$(a$, i + 1, 1)
                IF code$ = ":" THEN EXIT DO

                user$ = user$ + code$
                i = i + 1
                IF i = lline THEN EXIT DO
            LOOP
            IF LEN(user$) < 7 THEN GOTO secinput
            secindex# = secindex# + 1
            PRINT #2, RIGHT$(user$, LEN(user$) - 1)
        END IF
        k = 1
    NEXT
    REM second line
    FOR i = -1 TO lline
        code$ = LEFT$(a$, 1)

        IF LEFT$(a$, 2) = "0." THEN

            k = i + 1
            code$ = MID$(a$, i + 1, 1)
            user$ = ""
            DO
                code$ = MID$(a$, i + 1, 1)
                IF code$ = ":" THEN EXIT DO

                user$ = user$ + code$
                i = i + 1
                IF i = lline THEN EXIT DO
            LOOP
            IF LEN(user$) < 7 THEN GOTO secinput
            secindex# = secindex# + 1
            user$ = user$ + ":"
            PRINT #3, RIGHT$(user$, LEN(user$) - 1)
        END IF
        k = 1
    NEXT

LOOP
CLOSE #1: CLOSE #2: CLOSE #3
REM Linux
'OPEN "/home/john/Downloads/Freenet/secipt.txt" FOR INPUT AS #1
'OPEN "/home/john/Downloads/Freenet/secip.txt" FOR OUTPUT AS #2

REM Windows
OPEN "e:\qb\Freenet\secipt.txt" FOR INPUT AS #1
OPEN "e:\qb\Freenet\secconnip.txt" FOR OUTPUT AS #2
DO WHILE NOT EOF(1)
    lenstart = 0
    code$ = ""
    secconninput:
    IF NOT EOF(1) THEN LINE INPUT #1, a$
    lineindex# = lineindex# + 1
    lline = LEN(a$)
    code$ = ""


    FOR i = -1 TO lline
        code$ = MID$(a$, i + 1, 1)
        ' code$ = LEFT$(a$, 1)
        IF code$ = "/" THEN
            k = i + 1
            code$ = MID$(a$, i + 1, 1)
            user$ = ""
            DO
                code$ = MID$(a$, i + 1, 1)
                IF code$ = ":" THEN EXIT DO

                user$ = user$ + code$
                i = i + 1
                IF i = lline THEN EXIT DO
            LOOP
            IF LEN(user$) < 7 THEN GOTO secconninput
            secindex# = secindex# + 1
            PRINT #2, RIGHT$(user$, LEN(user$) - 1)
        END IF
        k = 1
    NEXT
LOOP




RETURN





trapip:
REM Traps IP's
DO WHILE NOT EOF(1)
    lenstart = 0
    code$ = ""
    newinput:
    IF NOT EOF(1) THEN LINE INPUT #1, a$
    lineindex# = lineindex# + 1
    lline = LEN(a$)
    code$ = ""

    FOR i = -1 TO lline
        code$ = MID$(a$, i + 1, 1)
        IF code$ = "]" THEN
            k = i + 1
            code$ = MID$(a$, i + 1, 1)
            user$ = ""
            DO
                code$ = MID$(a$, i + 1, 1)
                IF code$ = ":" THEN EXIT DO
                user$ = user$ + code$
                i = i + 1
                IF i = lline THEN EXIT DO
            LOOP
            IF LEN(user$) < 4 THEN GOTO newinput
            secindex# = secindex# + 1
            PRINT #2, RIGHT$(user$, LEN(user$) - 2)
        END IF
        k = 1
    NEXT
LOOP

RETURN

postproc:
REM Linux
'OPEN "/home/john/Downloads/Freenet/allipt.txt" FOR OUTPUT AS #1
'OPEN "/home/john/Downloads/Freenet/connip.txt" FOR INPUT AS #2
'OPEN "/home/john/Downloads/Freenet/backip.txt" FOR INPUT AS #3
'OPEN "/home/john/Downloads/Freenet/secip.txt" FOR INPUT AS #4
'OPEN "/home/john/Downloads/Freenet/secconnip.txt" FOR INPUT AS #5
'OPEN "/home/john/Downloads/Freenet/allip.txt" FOR OUTPUT AS #6


REM Windows
OPEN "e:\qb\Freenet\allipt.txt" FOR OUTPUT AS #1
OPEN "e:\qb\Freenet\connip.txt" FOR INPUT AS #2
OPEN "e:\qb\Freenet\backip.txt" FOR INPUT AS #3
OPEN "e:\qb\Freenet\secip.txt" FOR INPUT AS #4
OPEN "e:\qb\Freenet\secconnip.txt" FOR INPUT AS #5
OPEN "e:\qb\Freenet\allip.sh" FOR OUTPUT AS #6

DO WHILE NOT EOF(2)
    LINE INPUT #2, a$
    a$ = "ping -s 65000 -w 10 -t .003 " + a$
    PRINT #1, a$
LOOP

DO WHILE NOT EOF(3)
    LINE INPUT #3, a$
    a$ = "ping -s 65000 -w 10 -t .003 " + a$
    PRINT #1, a$
LOOP
FOR i = 1 TO 4
    LINE INPUT #4, a$
NEXT
DO WHILE NOT EOF(4)
    LINE INPUT #4, a$
    a$ = "ping -s 65000 -w 10 -t .003 " + a$
    IF RIGHT$(a$, 1) = "/" THEN EXIT DO
    PRINT #1, a$
LOOP

FOR i = 1 TO 6
    LINE INPUT #5, a$
NEXT
DO WHILE NOT EOF(5)
    LINE INPUT #5, a$
    a$ = "ping -s 65000 -w 10 -t .003 " + a$
    PRINT #1, a$
LOOP
CLOSE #1
OPEN "e:\qb\Freenet\allipt.txt" FOR INPUT AS #1

PRINT #6, "#!/bin/sh"
DO WHILE NOT EOF(1)
    LINE INPUT #1, a$
    REM Filter external IP's you dont want in the list adjust lengh
    IF RIGHT$(a$, 15) = "102.125.147.158" THEN GOTO skipip
    PRINT #6, a$
    skipip:
LOOP


RETURN


LOCATE 12, 1
PRINT "IP's  Total                  "; secindex#
PRINT "Number of lines in peers.txt "; lineindex#
CLOSE #1: CLOSE #2: CLOSE #3: CLOSE #4: CLOSE #5: CLOSE #6
END
STOP


health:
LOCATE 16, 1
PRINT "Counters"
PRINT "IP's  Total                  "; secindex#
PRINT "Number of lines in peers.txt "; lineindex#
RETURN

