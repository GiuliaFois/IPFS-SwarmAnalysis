:: This batch script is meant to run when ipfs daemon is on, and with two command line parameters
:: the first parameter is the name of the output file the program write the data to
:: the second parameter is the number of seconds the program wait before re-iterating the loop
@ECHO off
set outfile=%1
set tout=%2
cd . > %outfile%
:GO
ECHO %DATE% %TIME% : Analisi swarm peers...
call ECHO %DATE% %TIME%>> %outfile%
call ipfs swarm peers>> %outfile%
call ECHO END>> %outfile%
ECHO Fine analisi
TIMEOUT %tout% >nul
goto GO
