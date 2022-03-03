#!/system/bin/sh

wait_until_login()
{
    # in case of /data encryption is disabled
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done

    # we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
    local test_file="/sdcard/Android/.AGHFMTEST"
    true > "$test_file"
    while [ ! -f "$test_file" ] ; do
        true > "$test_file"
        sleep 1
    done
    rm "$test_file"
}

#wait_until_login

scripts=`realpath $0`
scripts_dir=`dirname ${scripts}`

if [ -f /data/AdGuardHome/AdGuardHome.pid ] ; then
    rm -f /data/AdGuardHome/AdGuardHome.pid
fi

if [ ! -f /data/AdGuardHome/manual ] ; then
    ${scripts_dir}/control -s
fi
