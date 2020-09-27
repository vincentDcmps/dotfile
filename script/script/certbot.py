import datetime
import socket
import ssl

import sys

HOSTNAME="www.ducamps.win"
WEBSERVEURUNIT="nginx.service"

def ssl_expiry_datetime(hostname: str) -> datetime.datetime:
    ssl_date_fmt = r'%b %d %H:%M:%S %Y %Z'

    context = ssl.create_default_context()
    conn = context.wrap_socket(
        socket.socket(socket.AF_INET),
        server_hostname=hostname,
    )
    # 3 second timeout because Lambda has runtime limitations
    conn.settimeout(3.0)
    conn.connect((hostname, 443))
    
    ssl_info = conn.getpeercert()
    # parse the string from the certificate into a Python datetime object
    return datetime.datetime.strptime(ssl_info['notAfter'], ssl_date_fmt)

try:
    ssl_remaining=ssl_expiry_datetime(HOSTNAME ) - datetime.datetime.utcnow()
except ConnectionRefusedError:
    print(f"can't connect to {HOSTNAME}")
    sys.exit(0)
except socket.gaierror:
    print(f"{HOSTNAME} not exist")
    sys.exit(0)

if ssl_remaining.days < 5 :
    print("certificat will expire in  {0} launch renewal procedure".format(ssl_remaining))
    print("stopping {0}".format(WEBSERVEURUNIT))
    print("renewal cert")
    print("starting {0}".format(WEBSERVEURUNIT))

else:
    print("certificat will expire in  {0} no renewal need".format(ssl_remaining))
    sys.exit(0)
