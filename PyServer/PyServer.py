#!/usr/bin/env python3
__author__ = 'raven'

# Create a Base HTTP Server and process some simple client request for testing purpose

import http.server
import time
import logging
from logging.handlers import RotatingFileHandler

LOG_FORMAT = '%(asctime)-15s %(message)s'

logging.basicConfig(format=LOG_FORMAT)

rthdlr = RotatingFileHandler("PSLog.txt", maxBytes=2 * 1024 * 1024)
formater = logging.Formatter(LOG_FORMAT)
rthdlr.setFormatter(formater)
rthdlr.setLevel(logging.INFO)
logger = logging.getLogger(__name__)
logger.addHandler(rthdlr)
logger.setLevel(logging.INFO)

logger.info('%s: Initiating...', time.ctime())


class MyHTTPServer(http.server.BaseHTTPRequestHandler):
    body = ''
    bodyLength = None

    def parse_request(self):
        if http.server.BaseHTTPRequestHandler.parse_request(self) is False:
            return False
        self.bodyLength = self.headers.get('Content-Length')
        if self.bodyLength is not None:
            self.body = self.rfile.read(int(self.bodyLength)).decode('utf-8')

        return True

    def logHeader(self):
        logger.debug("> [Incoming Req Headers]: \n%s", self.headers)
        logger.info("> [Incoming Req]: (%s)%s", self.command, '' if self.body is None else self.body)

    def do_GET(self):
        logger.debug("-----[GET]-----")
        self.logHeader()
        outmessage = time.ctime().encode('utf-8')
        self.send_response(200)
        self.end_headers()
        self.wfile.write(outmessage)
        logger.info("< [Out-going Rsp]: %s", outmessage)

    def do_POST(self):
        logger.debug("-----[POST]-----")
        self.logHeader()
        outmessage = ''
        if self.bodyLength is not None:
            outmessage = ("'%s' received" % self.body).encode('utf-8')
        self.send_response(200)
        self.end_headers()
        self.wfile.write(outmessage)
        logger.info("< [Out-going Rsp]: %s", outmessage)


httpd = http.server.HTTPServer(('', 8000), MyHTTPServer)
httpd.serve_forever()
