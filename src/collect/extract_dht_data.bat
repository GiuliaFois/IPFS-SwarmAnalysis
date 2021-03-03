:: This batch script is meant to run when ipfs daemon is on, and with three command line parameters
:: the first parameter is the name of the output file the program write the data to
:: the second parameter is the number of seconds the program wait before re-iterating the loop
:: the third parameter is the peer ID
@ECHO off
set outfile=%1
set tout=%2
set pId=%3
cd . > %outfile%
:GO
ECHO Analisi contenuto dht...
call ECHO %DATE% %TIME%>> %outfile%
call ipfs dht query %pId%>> %outfile%
call ECHO END>> %outfile%
TIMEOUT %tout% >nul
goto GO