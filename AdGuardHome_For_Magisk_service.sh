#!/system/bin/sh

module_dir="/data/adb/modules/AdGuardHome_For_Magisk"
scripts_dir="${module_dir}/scripts"

(
until [ $(getprop sys.boot_completed) -eq 1 ] ; do
  sleep 2
done
${scripts_dir}/start.sh
)&

inotifyd ${scripts_dir}/AdGuardHome.inotify ${module_dir} >> /dev/null &