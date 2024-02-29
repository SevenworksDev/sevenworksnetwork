import requests, os, sys
from urllib.parse import quote

pkg = os.path.join("C:\\", ".sevenworks", "packages")
os.makedirs(pkg, exist_ok=True)
os.system("cls")

def checkpath():
    if os.path.join("C:\\", ".sevenworks", "packages") in os.environ["PATH"].split(";"):
        return True
    else:
        return False

def checkauth():
    if os.path.exists(os.path.join("C:\\", ".sevenworks", "authtoken.txt")) and os.path.exists(os.path.join("C:\\", ".sevenworks", "username.txt")):
        return True
    else:
        return False

if not checkpath(): print("\033[91m[setup]:\033[0m add the following to %PATH% to run tools easier: C:\.sevenworks\packages\n")
if not checkauth(): print("\033[91m[setup]:\033[0m link your account using the 'auth' command\n")

print("sevenworks network [ver: indev]\ninput 'help' for a list of commands\n\n")
clientuser = open(os.path.join("C:\\", ".sevenworks", "username.txt")).read().strip() if os.path.exists(os.path.join("C:\\", ".sevenworks", "username.txt")) else "unauthorized"

helpmsg = """sevenworks:// network help
{} = argument

Core:
help - displays this message
version - displays current version
run {command} - runs either a package or a windows command
argstest {msg} - returns an argument

Sevenworks Network:
auth - login with sevenworks network
snget {package_name} - downloads a package to windir to be executed
"""

def auth():
    username = input("Enter your username: ")
    password = input("Enter your password: ")
    try:
        req = requests.get(f"http://auth.sevenworks.eu.org/gettoken?username={quote(username, safe='')}&password={quote(password, safe='')}")
        req.raise_for_status()
        if req.text.strip().startswith("-"):
            print("Authentication failure.")
        else:
            os.makedirs(os.path.dirname(os.path.join("C:\\", ".sevenworks", "authtoken.txt")), exist_ok=True)
            os.makedirs(os.path.dirname(os.path.join("C:\\", ".sevenworks", "username.txt")), exist_ok=True)
            with open(os.path.join("C:\\", ".sevenworks", "authtoken.txt"), "w") as file: file.write(req.text.strip())
            with open(os.path.join("C:\\", ".sevenworks", "username.txt"), "w") as file: file.write(username)
            print("Authentication is successful, restart the client.")
    except Exception as e:
        print(f"Authentication server failed to reach. {str(e)}")


def snget(package_name):
    try:
        os.makedirs(os.path.dirname(os.path.join("C:\\", ".sevenworks", "packages")), exist_ok=True)
        print(f"Downloading {package_name}")
        req = requests.get(f"https://raw.githubusercontent.com/SevenworksDev/sevenworksnetwork/main/packages/{package_name}.exe")
        req.raise_for_status()
        with open(os.path.join("C:\\", ".sevenworks", "packages", package_name)+".scr", "wb") as file: file.write(response.content)
        print(f"{package_name} is now installed.")
    except requests.exceptions.RequestException as e:
        print(f"{package_name} doesn't exist or a serious error occurred.")

def help():
    print(f"{helpmsg}")

def version():
    print("indev")

def argstest(msg):
    print(f"Argument: {msg}")

try:
    if sys.argv[1] == "auth":
        auth()
        input()
        sys.exit()
    elif sys.argv[1] == "test":
        input("sevenworks:// protocol works")
        sys.exit()
    else:
        pass
except:
    pass

actions = {"help": help, "version": version, "argstest": argstest, "auth": auth, "snget": snget}

while True:
    cmd = input(f"\033[95m{clientuser} />\033[0m ").split()
    if not cmd:
        continue
    if cmd[0] == 'run':
        cwd = os.getcwd()
        os.chdir("C:\.sevenworks\packages")
        os.system(" ".join(cmd[1:]))
        os.chdir(cwd)
        print("\n")
    else:
        if cmd[0] in actions:
            try:
                actions[cmd[0]](*cmd[1:])
            except:
                print(f"Error trying to execute {comd[0]}.")
        else:
            print(f"Command {cmd[0]} not found.")