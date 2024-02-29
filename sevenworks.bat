@echo off
if not "%%1"=="" (
    if "%%1"=="sevenworks://client/" (
        "C:\.sevenworks\sevenworks.exe"
    ) else if "%%1"=="sevenworks://auth/" (
        "C:\.sevenworks\sevenworks.exe" auth
    ) else if "%%1"=="sevenworks://test/" (
        "C:\.sevenworks\sevenworks.exe" test
    ) else if "%%1"=="sevenworks://dashboard/" (
        explorer "https://sevenworks.eu.org/network/dashboard.php"
    ) else if "%%1"=="sevenworks://developers/" (
        explorer "https://sevenworks.eu.org/network/developers/"
    ) else if "%%1"=="sevenworks:client/" (
        "C:\.sevenworks\sevenworks.exe"
    ) else if "%%1"=="sevenworks:auth/" (
        "C:\.sevenworks\sevenworks.exe" auth
    ) else if "%%1"=="sevenworks:test/" (
        "C:\.sevenworks\sevenworks.exe" test
    ) else if "%%1"=="sevenworks:dashboard/" (
        explorer "https://sevenworks.eu.org/network/dashboard.php"
    ) else if "%%1"=="sevenworks:developers/" (
        explorer "https://sevenworks.eu.org/network/developers/"
    ) else (
        echo valid links: client, dashboard, developers, auth, test
    )
) else (
    echo what
)
pause
