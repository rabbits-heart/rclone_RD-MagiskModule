# shellcheck disable=SC2034
SKIPUNZIP=1
extract() {
    zip=$1
    file=$2
    dir=$3
    junk_paths=$4
    [ -z "$junk_paths" ] && junk_paths=false
    opts="-o"
    [ $junk_paths = true ] && opts="-oj"

    file_path=""
    if [ $junk_paths = true ]; then
        file_path="$dir/$(basename "$file")"
    else
        file_path="$dir/$file"
    fi
    unzip $opts "$zip" "$file" -d "$dir" >&2
    [ -f "$file_path" ] || abort "$file not exists"

    ui_print "- Unzip $file" >&1
}
extract "$ZIPFILE" 'module.prop' "$MODPATH"
extract "$ZIPFILE" 'service.sh' "$MODPATH"
extract "$ZIPFILE" 'uninstall.sh' "$MODPATH"
extract "$ZIPFILE" "syncd.sh" "$MODPATH"
mkdir -p "$MODPATH/system/bin"
extract "$ZIPFILE" "common/binary/$ARCH/inotifywait" "$MODPATH/system/bin" true
extract "$ZIPFILE" "system/bin/rclone" "$MODPATH"
extract "$ZIPFILE" "common/binary/$ARCH/rclone" "$MODPATH" true

if [ "$IS64BIT" = true ]; then
    mkdir -p "$MODPATH/system/lib64"
    extract "$ZIPFILE" "common/lib/$ARCH/libandroid-support.so" "$MODPATH/system/lib64" true
else
    mkdir -p "$MODPATH/system/lib"
    extract "$ZIPFILE" "common/lib/$ARCH/libandroid-support.so" "$MODPATH/system/lib" true
fi

extract "$ZIPFILE" "common/binary/$ARCH/fusermount" "$MODPATH/system/bin" true

set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm "$MODPATH"/service.sh 0 0 0755
set_perm "$MODPATH"/syncd.sh 0 0 0755
set_perm "$MODPATH"/rclone 0 0 0755
[ -d "$MODPATH/system/bin" ] && set_perm_recursive "$MODPATH/system/bin" 0 0 0755 0755
[ -d "$MODPATH/system/lib" ] && set_perm_recursive "$MODPATH/system/lib" 0 0 0755 0644 u:object_r:system_lib_file:s0
[ -d "$MODPATH/system/lib64" ] && set_perm_recursive "$MODPATH/system/lib64" 0 0 0755 0644 u:object_r:system_lib_file:s0
USER_CONFDIR_OLD=/sdcard/.rclone
USER_CONFDIR=/sdcard/Android/.rclone
USER_CONF=$USER_CONFDIR/rclone.conf
USER_CONF_OLD=$USER_CONFDIR_OLD/rclone.conf
if [ -f "$USER_CONF" ]; then
    ui_print
    ui_print "- Please reboot to take effect"
    ui_print
elif [ -f "$USER_CONF_OLD" ] && [ ! -d "$USER_CONFDIR" ]; then
    ui_print "- Migrating config file to $USER_CONFDIR"
    mkdir -p "$USER_CONFDIR"
    mv "$USER_CONFDIR_OLD"/* "$USER_CONFDIR"/
    rm -rf "${USER_CONFDIR_OLD:?}"
else
    ui_print "'$USER_CONF' not found!"
    ui_print
    ui_print "Additional setup required..."
    ui_print "------------------------------------"
    ui_print " Instructions:                      "
    ui_print " - Open Terminal                    "
    ui_print " - Type 'su' & tap enter            "
    ui_print " - Type 'rclone config' & tap enter "
    ui_print " - Follow on screen options.        "
    ui_print "------------------------------------"
fi
