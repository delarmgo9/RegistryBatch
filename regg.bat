@ECHO OFF

REM -----------------------------------------
REM BACKUP DE TOUTE LA BASE DE REGISTRE : (*.reg dans le dossier REGBACKUP sur le Bureau de l'Utilisateur loggué)

IF NOT EXIST %USERPROFILE%\Desktop\REGBACKUP GOTO MAKEDIR
RMDIR /Q /S %USERPROFILE%\Desktop\REGBACKUP
:MAKEDIR
MKDIR %USERPROFILE%\Desktop\REGBACKUP

FOR %%K IN (LM CU CR U CC) DO @REG.EXE EXPORT HK%%K %USERPROFILE%\Desktop\REGBACKUP\hk%%K.reg


REM -----------------------------------------
REM RECHERCHE DE LA VALEUR "tototest" DANS LA CLEF "Couleur" :

set Coul=1
for /f "tokens=4" %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\ABC\QSD\Impression\BLCo" /V Couleur ^|findstr /sli "REG_SZ"') do set Coul=%%a


REM -----------------------------------------
REM SI VALEUR "tototest" PRESENTE GOTO CHANGE_VAL :

if "%Coul%"=="tototest" GOTO CHANGE_VAL
REM SINON
GOTO ENDD1


REM -----------------------------------------
REM REMPLACE "Bleu tototest" PAR "Bleu" :

:CHANGE_VAL
REG ADD "HKLM\SOFTWARE\Wow6432Node\ABC\QSD\Impression\BLCo" /f /v Couleur /t REG_SZ /d bleu
ECHO La Valeur recherch‚e a bien ‚t‚ remplac‚e.

GOTO ENDD2


REM -----------------------------------------
REM SI VALEUR "tototest" NON PRESENTE :

:ENDD1

ECHO La Valeur recherch‚e n'a pas ‚t‚ trouv‚e.


REM -----------------------------------------

:ENDD2

