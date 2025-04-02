# Script to add all GitHub IPs to an IPSet on PVE
import requests
import os

headers = {'Authorization': 'TOKEN'}
response = requests.get('https://api.github.com/meta')
data = response.json()
cats = ['hooks', 'web', 'api', 'git', 'github_enterprise_importer', 'packages', 'pages', 'importer', 'actions', 'actions_macos', 'codespaces', 'dependabot', 'copilot']

ips = []

for cat in cats:
    for ip in data[f'{cat}']:
        ips.append(ip)

ips = list(set(ips))

for ip in ips:
    cmd = f'pvesh create /cluster/firewall/ipset/github -cidr {ip}'
    os.system(cmd)
