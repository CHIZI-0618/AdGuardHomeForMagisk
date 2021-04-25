#!/sbin/sh

SKIPUNZIP=1

if [ ${BOOTMODE} ! = true ] ; then
    abort "! Please install in Magisk Manager"
fi

ui_print "- Extracting module files"
unzip -o "${ZIPFILE}" -x 'META-INF/*' -d ${MODPATH} >&2

ui_print "- Start setting permissions"
set_perm_recursive ${MODPATH} 0 0 0755 0644
set_perm_recursive ${MODPATH}/scripts 0 0 0755 0755
set_perm ${MODPATH}/system/bin/AdGuardHome 0 0 6755
