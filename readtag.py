#!/usr/bin/env python
# -*- coding: utf-8 -*-
import time
import sys
import re
import keyboard
import urllib2

def main():
	try:
		while True:
			v = ''
			v = keyboard.record(until='enter')
			card = ''.join(e.name for e in v if e.event_type == 'down' and len(e.name) == 1)
			card = str(card)
			card = card.upper();
			conn = urllib2.httplib.HTTPConnection('localhost')
			headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
			conn.request('POST', '/ProjetoRFID/view/recebeCracha.php', 'cartao='+card, headers)
	except KeyboardInterrupt:
		pass

if __name__ == '__main__':
	main()
