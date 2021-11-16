# Firmware Openwrt for Cudy X6

Check [Releases](https://github.com/julyworlds/openwrt-cudy-x6-firmware/releases) to download the firmware.

Modules added:
- Luci
  - app openvpn
  - app sqm
  - app ddns
  - app upnp
- Theme openwrt 2020

Installation:

1. Download and flash the manufacturer's built OpenWRT image available at
http://www.cudytech.com/openwrt_software_download
(Need to install first due to signed firmware verification)

2. Install any OpenWRT image via luci (System -> Backup/Flash firmware)
Be sure to NOT keep settings. The force upgrade might need to be checked
due to differences in router naming conventions.

Recovery:

Only signed manufacture firmwares due to bootloader RSA verification

1. TFTP-Server with file /recovery.bin active on 192.168.1.88/24
2. Power on the device while holding the reset button for quite a few seconds (wait at least 15 seconds so the image is downloaded)
