# This script assumes the keys you're wanting to copy are in ~/.ssh/
import sys
import subprocess
import os
import getpass

if len(sys.argv) < 3:
    print("Usage:\npython3 ssh-key-copy.py <remote_host> <key1> [<key2> ...]")
    sys.exit(1)

host = sys.argv[1]
keys = sys.argv[2:]
current_user = getpass.getuser()
ssh_dir = f'/home/{current_user}/.ssh'

for key in keys:
    if not os.path.exists(f'{ssh_dir}/{key}') or not os.path.exists(f'{ssh_dir}/{key}.pub'):
        print(f"Error: Key '{key}' or '{key}.pub' does not exist.")
        continue
    
    privcmd = ['scp', '-r', f'{ssh_dir}/{key}', f'{host}:~/.ssh/']
    pubcmd = ['scp', '-r', f'{ssh_dir}/{key}.pub', f'{host}:~/.ssh/']
    privresult = subprocess.run(privcmd, capture_output=True, text=True, check=True)
    pubresult = subprocess.run(pubcmd, capture_output=True, text=True, check=True)
    
    if privresult.returncode == 0:
        print(f"Successfully copied private key '{key}' to {host}")
    else:
        print(f"Failed to copy private key '{key}' to {host}")

    if pubresult.returncode == 0:
        print(f"Successfully copied public key '{key}' to {host}")
    else:
        print(f"Failed to copy public key '{key}' to {host}")

