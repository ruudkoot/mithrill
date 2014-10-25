@ECHO OFF

SET ROOT=D:\Mithrill
SET PATH=%ROOT%\bin\bochs;%ROOT%\bin\gcc;%ROOT%\bin\make;%ROOT%\bin\nasm;%ROOT%\bin\trifs-tools

CD %ROOT%\core\ia32
MAKE

PAUSE