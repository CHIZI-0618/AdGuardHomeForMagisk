# AdGuardHomeForMagisk

## 安装
下载 [Releases](https://github.com/CHIZI-0618/AdGuardHomeForMagisk/releases) 里的发布包, Magisk Manager 选择从本地安装, 安装过程会以音量键选择本地或在线安装 AdGuardHome 内核.

## 配置

安装后重启设备, 浏览器打开`http://127.0.0.1:3000`进行 AdGuardHome 初始化配置. **注意:** DNS 监听端口请设置为**非**`53`端口. 否则会导致安卓设备无法开启热点. 本模块会把 udp 53 端口的访问**重定向**至 AdGuardHome 的 `dns.port` .  
AdGuardHome 工作目录为`/data/AdGuardHome`, 初始化配置完成后会在该目录下生成 AdGuardHome 的配置文件 AdGuardHome.yaml , 之后更改配置请参照 AdguardTeam 提供的 [WiKi](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file).  
AdGuardHome 内核的更新可以在 AdGuardHome 网页面板检查并更新, 原内核和配置会备份.

## 控制

在 Magisk Manager 启用或禁用模块以启停 AdGuardHome 服务, 这是**实时的**, 并不需要重启你的设备.

## 卸载

在Magisk Manager里卸载, 卸载过程会删除所有配置, 请注意备份你的数据.
