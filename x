#!/bin/python3

import os
import argparse

def write_username_once():
    # Define the flag file and user file paths
    flag = os.path.expanduser("~/x/xs/Flag.flag")
    user_file = os.path.expanduser("~/x/xs/user.txt")

    # Check if the flag file exists
    if not os.path.exists(flag):
        # If the flag file doesn't exist, prompt for the username
        print("username of os")
        user = input("username: ")

        # Write the username to the user file
        with open(user_file, 'a') as f:
            f.write(user + "\n")

        # Create the flag file to indicate that the code has run once
        with open(flag, 'w') as f:
            f.write("This code has already run.")

    else:
        # If the flag file exists, read the username from the user file
        with open(user_file, 'r') as f:
            user = f.readline().strip()

    # Return the username for use in other parts of the script
    return user

def handle_su():
    # Handle the su subcommand
    new_user = input("new username: ")
    pwd = os.path.expanduser("~/x/xs/user.txt")

    # Remove the existing user file
    if os.path.exists(pwd):
        os.remove(pwd)

    # Write the new username to the user file
    with open(pwd, 'w') as f:
        f.write(new_user + "\n")

    print(f"user changed to '{new_user}'")

def main():
    try:
        # Create the top-level parser
        parser = argparse.ArgumentParser(description='Switch User For X')
        parser.add_argument('-su', action='store_true', help='Switch User')

        # Parse the arguments
        args = parser.parse_args()

        if args.su:
            handle_su()
        else:
            # Default action if no subcommand is provided
            user = write_username_once()
            # Execute other commands using the username
            os.system("rm zsh_history")
            os.system("clear")
            os.system("pkill -KILL -u " + user)
    except KeyboardInterrupt:
        print("\nOperation cancelled by user. Exiting...")

if __name__ == "__main__":
    main()
