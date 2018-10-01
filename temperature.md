# Reading a tempreature probe and sending it to AppOptics

Measure temperature with your Raspberry Pi [using the DS18B20](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-11-ds18b20-temperature-sensing/overview) and send the data to [AppOptics](https://www.appoptics.com).

```python
import os
import glob
import time
import requests

token = "1234abcd1234abcd1234abcd1234abcd1234abcd1234abcd"

os.system("modprobe w1-gpio")
os.system("modprobe w1-therm")
base_dir = "/sys/bus/w1/devices/"
device_folder = glob.glob(base_dir + "28*")[0]
device_file = device_folder + "/w1_slave"

def read_temp_raw():
    f = open(device_file, "r")
    lines = f.readlines()
    f.close()
    return lines

def read_temp():
    lines = read_temp_raw()
    while lines[0].strip()[-3: ] != "YES":
        time.sleep(0.2)
    lines = read_temp_raw()
    equals_pos = lines[1].find("t=")
    if equals_pos != -1:
        temp_string = lines[1][equals_pos + 2: ]
    temp_c = float(temp_string) / 1000.0
    temp_f = temp_c * 9.0 / 5.0 + 32.0
    return temp_c, temp_f

temp = read_temp()
payload = {
    "measurements": [
        {"name": "temperature", "value": temp[0], "tags": {"unit": "celsius","source": "raspberry"}},
        {"name": "temperature", "value": temp[1], "tags": {"unit": "fahrenheit","source": "raspberry"}}]}
print requests.post("https://api.appoptics.com/v1/measurements", auth=(token, ''), json=payload)
```
