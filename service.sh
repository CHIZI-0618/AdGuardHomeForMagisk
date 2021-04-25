#!/system/bin/sh

until [ $(getprop sys.boot_completed) -eq 1 ] ; do
    sleep 5
done

service_path=`realpath $0`
module_dir=`dirname ${service_path}`
scripts_dir="${module_dir}/scripts"

until [ -d "${module_dir}" ] ; do
    sleep 1
done

${scripts_dir}/control -s
inotifyd ${scripts_dir}/AdGuardHome.inotify ${module_dir} >> /dev/null &
