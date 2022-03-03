# AdGuardHomeForMagisk

## 安装

下载 [Releases](https://github.com/CHIZI-0618/AdGuardHomeForMagisk/releases) 里的发布包, Magisk Manager 选择从本地安装, 安装过程会以音量键选择本地或在线安装 AdGuardHome 内核.  
  

*Tips:*  
+ Releases 中的压缩包因包含多架构本地内核而体积较大, 如下载困难可考虑使用仅在线安装的版本 [AdGuardHomeForMagisk_Online.zip](https://raw.githubusercontent.com/CHIZI-0618/AdGuardHomeForMagisk/online/AdGuardHomeForMagisk_Online.zip) 大小不足7 KB.

## 配置

安装后重启设备, 浏览器打开`http://127.0.0.1:3000`进行 AdGuardHome 初始化配置.  
#### 注意:  
+ DNS 监听端口请设置为**非**`53`端口. 否则会导致安卓设备无法开启热点.  
+ 本模块会通过 iptables 将 udp 53 端口的访问**重定向**至 AdGuardHome 的 `dns.port` . 请提前判断是否与已有模块或软件冲突, 详情可咨询相关开发者.  
  

AdGuardHome 工作目录为`/data/AdGuardHome`, 初始化配置完成后会在该目录下生成 AdGuardHome 的配置文件 AdGuardHome.yaml , 之后更改配置请参照 AdguardTeam 提供的 [WiKi](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file).  
  

AdGuardHome 内核可以在 AdGuardHome 网页面板检查并更新, 原内核和配置会自动备份. 如更新失败请自行下载替换.

## 控制

AdGuardHome 服务默认会在系统启动后自动运行. 新建`/data/AdGuardHome/manual`文件可禁止 AdGuardHome 服务的自启动.  
可以通过 Magisk Manager 打开或关闭模块来启动或停止 AdGuardHome 服务, 这是**实时的**, 并不需要重启你的设备.

## 卸载

在 Magisk Manager 中卸载本模块, 卸载过程会删除 AdGuardHome 服务管理脚本, AdGuardHome 的数据目录`/data/AdGuardHome`不会删除.
