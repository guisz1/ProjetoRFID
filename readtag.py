#!/usr/bin/env python
# -*- coding: utf-8 -*-
import time
import RPi.GPIO as GPIO
import MFRC522
import urllib2

def main():
    try:
        LeitorRFID = MFRC522.MFRC522()
        while True:
            status, tag_type = LeitorRFID.MFRC522_Request(LeitorRFID.PICC_REQIDL)
            if status == LeitorRFID.MI_OK:
                print(status)
                status, uid = LeitorRFID.MFRC522_Anticoll()
                if status == LeitorRFID.MI_OK:
                    uid = ''.join('%02X' % c for c in uid)
                    print(uid)
                    conn = urllib2.httplib.HTTPConnection('localhost')
                    headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "text/plain"}
                    conn.request('POST', '/ProjetoRFID/view/recebeCracha.php', 'cartao='+uid, headers)
    except KeyboardInterrupt:
        GPIO.cleanup()

if __name__ == '__main__':
    main()
