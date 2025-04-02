# Script to add all GitHub IPs to an IPSet on PVE
import requests
import os

response = requests.get('https://api.github.com/meta')
data = response.json()
sets = ['hooks', 'web', 'api', 'git', 'github_enterprise_importer', 'packages', 'pages', 'importer', 'actions', 'actions_macos', 'codespaces', 'dependabot', 'copilot']

ips = []

for set in sets:
    for ip in data[f'{set}']:
        ips.append(ip)

for ip in ips:
    cmd = f'pvesh create /cluster/firewall/ipset/github -cidr {ip}'
    os.system(cmd)
