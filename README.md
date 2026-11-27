# ***WARNING***
Make sure to select your version for Cudy X6 `v1` or `v2`

The newer version `v2` has a different flash and flash layout. (Flash has been downgraded to 16M)

# Firmware Openwrt for Cudy X6

Check [Releases](https://github.com/julyworlds/openwrt-cudy-x6-firmware/releases) to download the firmware.

Firmware versions:
- (REMOVED OLD ONLY V1) stable-21.02-* (Based on the stable 21.02 **Recommended**)
- ***WARNING*** (Added to snapshot openwrt, you might use the official one) snapshot-* (Beware that this firmware is based on the development branch of openwrt and sometimes builds break, if that happens try with an older firmware or the stable version)

NOTE: The current versions of openwrt support cudy x6, use this snapshot firmware only if you dont want to build it yourself.

Images in each snapshot release:

| File | Device | EasyMesh |
|---|---|---|
| `*-cudy_x6-v1-squashfs-sysupgrade.bin` | v1 (32M flash) | yes |
| `*-cudy_x6-v2-mesh-squashfs-sysupgrade.bin` | v2 (16M flash) | yes |
| `*-cudy_x6-v2-squashfs-sysupgrade.bin` | v2 (16M flash) | no (more free space) |

Modules added:
- EasyMesh (prplMesh controller + agent, built from [our prplMesh fork](https://github.com/julyworlds/prplMesh/tree/openwrt) with size, mbedTLS, roaming and bug fixes)
  - Disabled by default, enable it in Network -> EasyMesh
  - Works with EasyMesh extenders (tested with TP-Link RE500X) for client roaming / steering
- Luci
  - app EasyMesh (status, topology, client steering and basic settings)
  - app adblock
  - app ddns
  - app sqm
  - app upnp
  - app package manager
  - proto openvpn
  - proto wireguard
  - proto ppp / ipv6
- Theme openwrt bootstrap
- Full wpad (mbedTLS): access point and WiFi client, WPA3, 802.11k/v/r
- dnsmasq, iperf3, curl

Removed to save space: opkg (apk is used), Lua LuCI compatibility, legacy
iptables tools (firewall4/nftables is used), ipset, ip-full (ip-tiny is used),
dnsmasq-full (DNSSEC, nftset/ipset and TFTP were not used), wolfSSL and OpenSSL
(everything uses mbedTLS, prplMesh included through a local patch).

Installation:

1. Download and flash the manufacturer's built OpenWRT image available at
http://www.cudytech.com/openwrt_software_download
(Need to install first due to signed firmware verification)

2. Install any OpenWRT image via luci (System -> Backup/Flash firmware)
Be sure to NOT keep settings. The force upgrade might need to be checked
due to differences in router naming conventions.

Recovery:

To download the stock firmware go to: https://www.cudytech.com/x6_software_download
(Optionally, you can find in this repository the stock firmware for `v1` dated on 2022-01-24) (X6-R13-1.12.7-20220123-205651-flash.zip)
(If using `v2` go to the manufacture's website and download it)

Only signed manufacture firmwares due to bootloader RSA verification

1. TFTP-Server with file /recovery.bin active on 192.168.1.88/24
2. Power on the device while holding the reset button for quite a few seconds (wait at least 15 seconds so the image is downloaded)
