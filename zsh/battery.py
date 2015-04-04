#!/usr/bin/env python
# coding=UTF-8

import math, subprocess

p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
output = p.communicate()[0]
properties = output.splitlines()

o_max = [l for l in properties if "MaxCapacity" in l.decode('utf-8')][0].decode("utf-8")
o_cur = [l for l in properties if "CurrentCapacity" in l.decode("utf-8")][0].decode("utf-8")

b_max = float(o_max.rpartition('=')[-1].strip())
b_cur = float(o_cur.rpartition('=')[-1].strip())

charge = b_cur / b_max
charge_threshold = int(math.ceil(10 * charge))

# Output

total_slots, slots = 10, []
filled = int(math.ceil(charge_threshold * (total_slots / 10.0))) * u'●'
empty = (total_slots - len(filled)) * u'○'

out = (filled + empty).encode('utf-8')
import sys

color_green = '%{[32m%}'
color_yellow = '%{[1;33m%}'
color_red = '%{[31m%}'
color_reset = '%{[00m%}'

color_green = color_green.encode('utf-8')
color_yellow = color_yellow.encode('utf-8')
color_red = color_red.encode('utf-8')
color_reset = color_reset.encode('utf-8')

color_out = (
    color_green if len(filled) > 6
    else color_yellow if len(filled) > 4
    else color_red
)

out = color_out + out + color_reset

try:
    sys.stdout.write(out.decode('utf-8'))
except UnicodeEncodeError:
    sys.stdout.write(out)
