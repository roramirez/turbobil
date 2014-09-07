#!/usr/bin/python
'Class dialer for Turbobil'
__author__    = "Rodrigo Ramirez Norambuena"
__version__   = "0.1.0"
__email__     = "rodrigo@blackhole.cl"

import time
import math

class dialer:

    def __init__(self, agi):
        self.agi = agi
        self.answertime = 0
        self.init = 0
        self.end = 0

    def get_vars(self):
        agi_vars = {}
        vars = { "ip" : "CHANNEL(recvip)", \
                 "hangupcause" : "HANGUPCAUSE"}

        for key in vars.keys():
            try:
                agi_vars[key] = self.agi.get_variable(vars[key])
                if agi_vars[key] == '' or agi_vars[key] == "''":
                    agi_vars[key] = None
            except:
                agi_vars[key] = None
        return agi_vars

    def dial(self, dial_str):
        try:
            self.agi.execute('EXEC Dial', '%s' % (dial_str))
            self.dialstatus = self.agi.get_variable("DIALSTATUS")
        except:
            try:
                self.dialstatus = self.agi.get_variable("DIALSTATUS")
                self.answeredtime = self.agi.get_variable("ANSWEREDTIME")
            except:
                pass

        self.end = time.time()
        if self.dialstatus == 'ANSWER':
            try:
                self.answeredtime = int(self.answeredtime)
            except:
                #when var ANSWEREDTIME is ''
                self.answeredtime = 0
            self.init = self.end - self.answeredtime
        else:
            self.answeredtime = 0
            self.init = self.end

        agi_vars = self.get_vars()
        result = {}
        result['init'] = self.init
        result['end'] = self.end
        result['dialstatus'] = self.dialstatus
        result['answeredtime'] = int(self.answeredtime)
        result['ip'] = agi_vars['ip']
        result['hangupcause'] = agi_vars['hangupcause']

        return (result)
