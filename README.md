# AdGuardHomeForMagisk

## 安装
下载[Releases](https://github.com/CHIZI-0618/AdGuardHomeForMagisk/releases)里的发布包, Magisk Manager选择从本地安装, 安装过程会以音量键选择本地或在线安装AdGuardHome内核.

## 配置

安装后重启设备, 浏览器打开`http://127.0.0.1:3000`进行AdGuardHome初始配置. 
AdguardHome工作目录为`{modules}/AdGuardHome_For_Magisk/scripts`, 初始配置完成后会在该目录下生成AdGuardHome配置文件AdGuardHome.yaml, 之后更改配置请参照AdguardTeam提供的[WiKi](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file).

## 控制

在Magisk Manager启用或禁用模块以启停AdGuardHome服务, 这是**实时的**, 并不需要重启你的设备.

## 卸载

在Magisk Manager里卸载, 卸载过程会删除所有配置, 请注意备份你的数据.
