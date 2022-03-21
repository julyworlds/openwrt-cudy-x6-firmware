# Firmware Openwrt for Cudy X6

Check [Releases](https://github.com/julyworlds/openwrt-cudy-x6-firmware/releases) to download the firmware.

Firmware versions:
- stable-21.02-* (Based on the stable 21.02 **Recommended**)
- snapshot-* (Beware that this firmware is based on the development branch of openwrt and sometimes builds break, if that happens try with an older firmware or the stable version)

Modules added:
- Luci
  - app adblock
  - app openvpn
  - app wireguard
  - app sqm
  - app ddns
  - app upnp
  - app vpn policy routing
- Theme openwrt bootstrap

Installation:

1. Download and flash the manufacturer's built OpenWRT image available at
http://www.cudytech.com/openwrt_software_download
(Need to install first due to signed firmware verification)

2. Install any OpenWRT image via luci (System -> Backup/Flash firmware)
Be sure to NOT keep settings. The force upgrade might need to be checked
due to differences in router naming conventions.

Recovery:

To download the stock firmware go to: https://www.cudytech.com/x6_software_download
(Optionally, you can find in this repository the stock firmware dated on 2022-01-24) (X6-R13-1.12.7-20220123-205651-flash.zip)

Only signed manufacture firmwares due to bootloader RSA verification

1. TFTP-Server with file /recovery.bin active on 192.168.1.88/24
2. Power on the device while holding the reset button for quite a few seconds (wait at least 15 seconds so the image is downloaded)
