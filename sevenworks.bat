@echo off
set "lmao=auth client test dashboard developers"

if not "%1"=="" (
    for %%i in (%keywords%) do (
        echo %1 | find /i "sevenworks://%%i" > nul && (
            if "%%i"=="dashboard" (
                explorer "https://sevenworks.eu.org/network/dashboard.php"
            ) else if "%%i"=="developers" (
                explorer "https://sevenworks.eu.org/network/developers/"
            ) else (
                "C:\.sevenworks\sevenworks.exe" %%i
            )
            exit /b
        )
    )
    echo valid links: %lmao%
) else (
    echo what
)
