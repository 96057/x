#!/usr/bin/python3

import os
import argparse

def write_username_once():
    # Define the flag file and user file paths
    flag = os.path.expanduser("~/x/xs/Flag.flag")
    user_file = os.path.expanduser("~/x/xs/user.txt")
    shell_file = os.path.expanduser("~/x/xs/shell.txt")

    # Check if the flag file exists
    if not os.path.exists(flag):
        # If the flag file doesn't exist, prompt for the username and shell
        print("Setting up initial user and shell configuration.")
        user = input("Enter username: ")
        shell = input("Enter shell: ")

        # Write the username to the user file
        with open(user_file, 'w') as f:
            f.write(user + "\n")

        # Write the shell to the shell file
        with open(shell_file, 'w') as f:
            f.write(shell + "\n")

        # Create the flag file to indicate that the code has run once
        with open(flag, 'w') as f:
            f.write("This code has already run.")

        return user, shell  # Return both user and shell

    else:
        # If the flag file exists, read the username from the user file
        with open(user_file, 'r') as f:
            user = f.readline().strip()

        # Read the shell from the shell file
        with open(shell_file, 'r') as f:
            shell = f.readline().strip()

        return user, shell  # Return both user and shell

def handle_su():
    # Handle the -su subcommand (change user)
    new_user = input("New username: ")
    user_file = os.path.expanduser("~/x/xs/user.txt")

    # Write the new username to the user file
    with open(user_file, 'w') as f:
        f.write(new_user + "\n")

    print(f"User changed to '{new_user}'")

def handle_cs():
    # Handle the -cs subcommand (change shell)
    new_shell = input("New shell: ")
    shell_file = os.path.expanduser("~/x/xs/shell.txt")

    # Write the new shell to the shell file
    with open(shell_file, 'w') as f:
        f.write(new_shell + "\n")

    print(f"Shell changed to '{new_shell}'")

def main():
    try:
        # Create the top-level parser
        parser = argparse.ArgumentParser(description='Switch User or Shell For X')
        parser.add_argument('-su', action='store_true', help='Switch User')
        parser.add_argument('-cs', action='store_true', help='Switch Shell')

        # Parse the arguments
        args = parser.parse_args()

        if args.su:
            handle_su()
        elif args.cs:
            handle_cs()
        else:
            # Default action if no subcommand is provided
            user, shell = write_username_once()
            # Execute other commands using the username and shell
            os.system("rm ."+shell+"_history")  # Example command, replace with actual logic
            os.system("clear")
            os.system("pkill -KILL -u " + user)  # Example command, replace with actual logic

    except KeyboardInterrupt:
        print("\nOperation cancelled by user. Exiting...")

if __name__ == "__main__":
    main()
