import subprocess
def terraform_run(command):
    process = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    print(process.stdout.decode())
    print(process.stderr.decode())

directory = "/root/todo-app"
commands = [
    f"terraform -chdir={directory} init",
    f"terraform -chdir={directory} plan",
    f"terraform -chdir={directory} apply -auto-approve"
]
for cmd in commands:
    terraform_run(cmd)
