#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate
# echo '添加 SSR Plus+'
git clone https://github.com/Mattraks/helloworld.git ./package/diy/ssrplus
# echo '添加 小猫咪'
git clone https://github.com/vernesong/OpenClash.git ./package/diy/OpenClash
# echo '添加 Passwall'
git clone https://github.com/xiaorouji/openwrt-passwall.git ./package/diy/passwall
# echo '添加 HelloWorld'
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/ package/diy/luci-app-vssr
# echo '添加 京东签到'
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ package/diy/luci-app-jd-dailybonus
# echo '添加 SmartDNS'
git clone https://github.com/pymumu/luci-app-smartdns.git -b lede ./package/diy/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git ./feeds/packages/net/smartdns
# echo '微信推送'
git clone https://github.com/tty228/luci-app-serverchan.git ./package/diy/luci-app-serverchan
# echo '汉化实时监控'
svn co https://github.com/gd0772/diy/trunk/public/luci-app-netdata ./package/lean/luci-app-netdata
svn co https://github.com/gd0772/diy/trunk/public/netdata ./feeds/packages/admin/netdata
# echo '替换USB打印'
svn co https://github.com/gd0772/diy/trunk/public/luci-app-usb-printer ./package/lean/luci-app-usb-printer


# 修复核心及添加温度显示
sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
# echo '更新feeds'
./scripts/feeds update -i
