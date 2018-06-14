@echo Backup database  %PG_PATH%%PG_FILENAME%
@echo off
SET PG_BIN="C:\Program Files\PostgreSQL\9.6\bin\pg_dump.exe"
SET PG_HOST=localhost
SET PG_PORT=5432
SET PG_DATABASE=postgres
SET PG_USER=postgres
SET PG_PASSWORD=12345
SET PG_PATH=C:\test
SET FECHAYHORA=%date:/=%-%time:-0,8%
SET FECHAYHORA=%FECHAYHORA::=-%
SET FECHAYHORA=%FECHAYHORA: =0%
SET PG_FILENAME=%PG_PATH%\%PG_DATABASE%_%d%_%t%.sql
SET PG_File=%PG_DATABASE%_%d%_%t%.backup 

%PG_BIN% -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -f %PG_File% %PG_DATABASE%

@echo Backup Taken Complete %PG_PATH%%PG_FILENAME%