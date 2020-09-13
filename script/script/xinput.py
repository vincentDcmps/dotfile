import re
import subprocess

ENABLE_OPTIONS = [
        "libinput Tapping Enabled",
       "libinput Natural Scrolling Enabled"
]
DEVICE=14

class XinputDevice (object):
    xinputList=b""
    def __init__(self,deviceNumber):
        deviceNumber=str(deviceNumber)
        self.deviceNumber=deviceNumber
        self._refresh()
    def enable(self,name):
        regex="{0} \(([0-9]*)\)".format(name)
        bregex=regex.encode('utf-8')
        try:
            optionNumber=re.findall(bregex,self.xinputList)[0]
        except IndexError:
            print("option not found")
            return

        proc=subprocess.Popen(['/usr/bin/xinput','set-prop',self.deviceNumber,optionNumber,'1'])
        self._refresh()
    def disable(self,name):
        regex="{0} \(([0-9]*)\)".format(name)
        bregex=regex.encode('utf-8')
        try:
            optionNumber=re.findall(bregex,self.xinputList)[0]
        except IndexError:
            print("option not found")
            return
        proc=subprocess.Popen(['/usr/bin/xinput','set-prop',self.deviceNumber,optionNumber,'0'])
        self._refresh()
    def _refresh (self):
        self.xinputList=subprocess.check_output(['/usr/bin/xinput','list-props',self.deviceNumber])


xinput=XinputDevice(DEVICE)
for option in ENABLE_OPTIONS :
    xinput.enable(option)

