#!/usr/bin/env python3
__author__ = 'raven'

# Create a Base HTTP Server and process some simple client request for testing purpose

import http.server
import time
import logging
from logging.handlers import RotatingFileHandler

LOG_FORMAT = '%(asctime)-15s %(message)s'

logging.basicConfig(format=LOG_FORMAT)

rthdlr = RotatingFileHandler("PSLog.txt", maxBytes=10*1024*1024)
formater = logging.Formatter(LOG_FORMAT)
rthdlr.setFormatter(formater)
rthdlr.setLevel(logging.DEBUG)
logger = logging.getLogger(__name__)
logger.addHandler(rthdlr)
logger.setLevel(logging.DEBUG)

logger.info('%s: Initiating...', time.ctime())

class MyHTTPServer(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        logger.debug("----- %s [GET]------", time.ctime())
        logger.debug("client address: %s", self.client_address)
        logger.debug("client command: %s", self.command)
        logger.debug("client request path: %s", self.path)
        logger.debug("client request version: %s", self.request_version)
        #print("client request: ", self.requestline)
        logger.debug("client request headers: \n%s", self.headers)
        length = self.headers.get('Content-Length')
        if length != None :
            logger.debug("length: %s", length)
            logger.debug("client message: %s", self.rfile.read(int(length)).decode('utf-8'))
        self.send_response(200)
        #self.send_header('Time', 'Now!')
        self.end_headers()
        outmessage = time.ctime().encode('utf-8')
        self.wfile.write(outmessage)
        logger.debug("OUT: %s", outmessage)

    def do_POST(self):
        logger.debug("----- %s [POST]------", time.ctime())
        logger.debug("client address: %s", self.client_address)
        logger.debug("client command: %s", self.command)
        logger.debug("client request path: %s", self.path)
        logger.debug("client request version: %s", self.request_version)
        #print("client request: ", self.requestline)
        logger.debug("client request headers: \n%s", self.headers)
        length = self.headers.get('Content-Length')
        cmessage = ''
        if length != None :
            logger.debug("length: %s", length)
            cmessage = self.rfile.read(int(length)).decode('utf-8')
            logger.debug("client message: %s", cmessage)
            cmessage = ("'%s' received" % cmessage).encode('utf-8')
        self.send_response(200)
        self.end_headers()
        self.wfile.write(cmessage)
        logger.debug("OUT: %s", cmessage)

httpd = http.server.HTTPServer(('', 8000), MyHTTPServer)
httpd.serve_forever()
