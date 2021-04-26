#!/sbin/sh

SKIPUNZIP=1

if [ ${BOOTMODE} ! = true ] ; then
    abort "! Please install in Magisk Manager"
fi

ui_print "- Extracting module files."
unzip -o "${ZIPFILE}" -x 'META-INF/*' -d ${MODPATH} >&2

ui_print "- Select installation mode:"
ui_print "- Vol Up = Local mod."
ui_print "- Vol Down = Online mod."
while true ; do
    getevent -lc 1 2>&1 | grep KEY_VOLUME > $TMPDIR/events
    sleep 1
    if $(cat $TMPDIR/events | grep -q KEY_VOLUMEUP) ; then
        mod="local"
        break
    elif $(cat $TMPDIR/events | grep -q KEY_VOLUMEDOWN) ; then
        mod="online"
        break
    fi
done

local_mod() {
    ui_print "- Start local installation."
    mkdir -p ${MODPATH}/system/bin/
    tar -zxvf ${MODPATH}/Core/AdGuardHome_linux_${ARCH}.tar.gz -C ${MODPATH} >&2
    mv -f ${MODPATH}/AdGuardHome/AdGuardHome ${MODPATH}/system/bin/
    rm -rf ${MODPATH}/Core
    rm -rf ${MODPATH}/AdGuardHome
}

online_mod() {
    ui_print "- Start online installation."
    AdGuardHome_link="https://github.com/AdguardTeam/AdGuardHome/releases"
    if $(curl -V > /dev/null 2>&1) ; then
        flag="true"
        latest_version=`curl -k -s -I "${AdGuardHome_link}/latest" | grep -i location | grep -o "tag.*" | grep -o "v[0-9.]*"`
    elif $(wget --help > /dev/null 2>&1) ; then
        flag="false"
        touch ${TMPDIR}/version
        wget --no-check-certificate -O ${TMPDIR}/version "${AdGuardHome_link}/latest"
        latest_version=`cat ${TMPDIR}/version | grep -o "tag.*" | grep -o "v[0-9.]*" | head -n1`
    else
        abort "! Please install the busybox module and try again."
    fi

    if [ "${latest_version}" = "" ] ; then
        abort "Error: Connect AdGuardHome download link failed."
    fi

    ui_print "- Download latest AdGuardHome ${latest_version}-${ARCH}."
    case "${ARCH}" in
        arm)
            download_AdGuardHome_link="${AdGuardHome_link}/download/${latest_version}/AdGuardHome_linux_armv7.tar.gz"
            ;;
        arm64)
            download_AdGuardHome_link="${AdGuardHome_link}/download/${latest_version}/AdGuardHome_linux_arm64.tar.gz"
            ;;
        x86)
            download_AdGuardHome_link="${AdGuardHome_link}/download/${latest_version}/AdGuardHome_linux_386.tar.gz"
            ;;
        x64)
            download_AdGuardHome_link="${AdGuardHome_link}/download/${latest_version}/AdGuardHome_linux_amd64.tar.gz"
            ;;
        esac

    if [ ${flag} == "true" ] ; then
        curl "${download_AdGuardHome_link}" -k -L -o "${MODPATH}/AdGuardHome.tar.gz" >&2
    else
        wget --no-check-certificate -O "${MODPATH}/AdGuardHome.tar.gz" "${download_AdGuardHome_link}" >&2
    fi

    if [ "$?" ! = "0"] ; then
        abort "Error: Download AdGuardHome Core failed."
    fi

    tar -zxvf ${MODPATH}/AdGuardHome.tar.gz -C ${MODPATH} >&2
    mkdir -p ${MODPATH}/system/bin/
    mv -f ${MODPATH}/AdGuardHome/AdGuardHome ${MODPATH}/system/bin/
    rm -rf ${MODPATH}/AdGuardHome
    rm -f ${MODPATH}/AdGuardHome.tar.gz
    rm -rf ${MODPATH}/Core
}

if [ "${mod}" == "local" ] ; then
    local_mod
elif [ "${mod}" == "online" ] ; then
    online_mod
else
    abort "- Selection error."
fi

if [ "${mod}" == "local" ] ; then
    break
elif [ "${mod}" == "online" ] ; then
    ui_print "- Update module.prop."
    rm -f ${MODPATH}/module.prop
    touch ${MODPATH}/module.prop
    echo "id=AdGuardHome_For_Magisk" > ${MODPATH}/module.prop
    echo "name=AdGuardHome For Magisk" >> ${MODPATH}/module.prop
    echo -n "version=" >> ${MODPATH}/module.prop
    echo ${latest_version} >> ${MODPATH}/module.prop
    echo "versionCode=$(date +%Y%m%d)" >> ${MODPATH}/module.prop
    echo "author=Module by CHIZI-0618. Core by AdguardTeam." >> ${MODPATH}/module.prop
    echo "description=Build AdGuard Home DNS server by Magisk." >> ${MODPATH}/module.prop
fi

ui_print "- Start setting permissions."
set_perm_recursive ${MODPATH} 0 0 0755 0644
set_perm_recursive ${MODPATH}/scripts 0 0 0755 0755
set_perm ${MODPATH}/system/bin/AdGuardHome 0 0 6755
