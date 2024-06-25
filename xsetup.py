#!/usr/bin/env python3

import os
import subprocess

def convert_to_unix_line_endings(file_path):
    with open(file_path, 'rb') as file:
        content = file.read()
    content = content.replace(b'\r\n', b'\n')
    with open(file_path, 'wb') as file:
        file.write(content)

def ensure_shebang(file_path):
    with open(file_path, 'r+') as file:
        content = file.read()
        if not content.startswith('#!/usr/bin/env python3\n'):
            content = '#!/usr/bin/env python3\n' + content
        file.seek(0)
        file.write(content)
        file.truncate()

def main():
    ans = input("Do you wish to update and upgrade your OS? y/n ")
    if ans == 'y':
        os.system("sudo apt update")
        os.system("sudo apt upgrade -y")
    
    os.system("sudo apt install python3 -y")
    os.system("sudo apt install python3-pip -y")
    os.system("pip install -r requirements.txt")

    script_name = "x"
    dest_path = "/usr/local/bin/x"

    # Ensure the script has the correct shebang and Unix line endings
    ensure_shebang(script_name)
    convert_to_unix_line_endings(script_name)

    # Make the script executable
    os.system(f"chmod +x {script_name}")

    # Move the script to /usr/local/bin
    os.system(f"sudo mv {script_name} {dest_path}")

    # Ensure /usr/local/bin is in the PATH
    if "/usr/local/bin" not in os.environ["PATH"]:
        with open(os.path.expanduser("~/.bashrc"), "a") as bashrc:
            bashrc.write("\nexport PATH=$PATH:/usr/local/bin\n")
        os.system("source ~/.bashrc")

    # Create necessary files and directories
    os.makedirs(os.path.expanduser("~/x/xs"), exist_ok=True)
    open(os.path.expanduser("~/x/xs/user.txt"), 'a').close()
    open(os.path.expanduser("~/x/xs/Flag.flag"), 'a').close()

    print("""
      ####################################
     ######################################
    #####           #####          #########
    ######           ###          ##########
    #######          ##          ###########
    ########        ##          ############
    #########      ##          #############
    ##########    ##          ##############
    ###########  ##          ###############
    ########### #          #################
    ############          ##################
    ###########          ##    #############
    ##########          ##      ############
    #########          ##        ###########
    ########          ##          ##########
    #######          ####          #########
    ######          ######          ########
    #####          ########           ######
     ######################################
       ###################################
    CREATED BY: 96057

    An Emergency command to delete the Shell History and Logout.

    REMEMBER!:
    Control and Privacy is an Illusion

    Type x and ENTER
    """)

if __name__ == "__main__":
    main()
