import subprocess
import time
import sys

services=("syncthing@vincent",
        "mariadb",
        "nginx",
        "php-fpm",
        "gitea",
        "tt-rss",
        "gunicorn-chainetv.socket",
        "gunicorn-supysonic",
        "rsyncd.service",
        "fail2ban",
        "supysonic-daemon",
        "home-assistant",
        "radicale")

containers=("pihole",)



class Service(object):
    def __init__(self, serviceName):
        self.name=serviceName
    
    def is_active(self):
        cmd="/usr/bin/systemctl"
        proc=subprocess.Popen([cmd,'is-active',self.name],stdout=subprocess.PIPE)
        proc.communicate()
        rc=proc.returncode
        if rc == 0:
            return True
        else:
            return False

    def get_last_log(self):
        cmd="/usr/bin/journalctl"
        proc=subprocess.check_output([cmd,'--lines=10','-q','-u',self.name])
        return proc.decode('UTF-8').split('\n')

class Container(object):
    def __init__(self, containerName):
        self.name=containerName

    def is_active (self):
        cmd="/usr/bin/docker"
        try:
            proc=subprocess.check_output([cmd,'ps'],stderr=subprocess.STDOUT)
        except:
            proc=b''
            pass
        proc=proc.decode('UTF-8')
        if (proc.find(self.name) != -1):
            return True
        else:
            return False


if __name__ == '__main__':
    wait=True
    if len(sys.argv) > 1:
        print(sys.argv[1])
        if sys.argv[1] == "nowait":
            wait=False
    
    if (wait):
        time.sleep(60)


    for serviceName in services:
        serviceObj=Service(serviceName)
        if (serviceObj.is_active()):
            print (f"{serviceObj.name} is active")
        else:
            print (f"{serviceObj.name} is inactive")
            for line in serviceObj.get_last_log():
                print(line) 
    for containerName in containers:
        containerObj=Container(containerName)
        if containerObj.is_active():
            print (f"{containerObj.name} is active")
        else:
            print (f"{containerObj.name} is inactive")
