import SimpleHTTPServer
import SocketServer
import logging
import cgi
import subprocess
import os
import platform
import time

os.environ["DISPLAY"] = ":0"
PORT = 8000
#get the hostname of the pi
hostname = platform.node()
hostname_url = "http://" + hostname + ".local"

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    def do_GET(self):
        logging.error(self.headers)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        logging.error(self.headers)
        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={'REQUEST_METHOD':'POST',
                     'CONTENT_TYPE':self.headers['Content-Type'],
                     })
        url = str(form.getvalue("url"))
        #kill all browswer instances
        process = subprocess.call(["sudo", "/usr/bin/pkill", "-f", "chromium-browser"])
        #start browser with url
        web_command = ['chromium-browser',url]
        print "Running > ", web_command, " < as a sub process"
        subprocess.Popen(web_command )
        print "zzzzzzz....."
        time.sleep(20)
        print "Robot is hitting the F11 key"
        subprocess.Popen('WID=`xdotool search --class chromium-browser`; xdotool windowactivate $WID; xdotool key --clearmodifiers F11',shell=True)
        #subprocess.call(['xdotool', 'key', '-clearmodifiers F11'])
        print " ----- done -----"
        self.send_response(301)
        self.send_header("Location", hostname_url)
        self.end_headers()

Handler = ServerHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()
