<h1 align="center">Cloud Storage Mounter for Magisk (prev: rclone-mount)</h1>

<div align="center">
  <!-- Version -->
    <img src="https://img.shields.io/github/v/release/rabbits-heart/rclone-mount-magisk?color=teal&style=for-the-badge"
      alt="Version" />
  <!-- Release Date -->
    <img src="https://img.shields.io/github/release-date/rabbits-heart/rclone-mount-magisk?color=pink&style=for-the-badge"
      alt="_time_stamp_" />
  <!-- Min Magisk -->
    <img src="https://img.shields.io/badge/Magisk-20.4%2B-magenta?&style=for-the-badge"
      alt="_time_stamp_" /></div>

<div align="center">
  <strong>This is the spiritual successor of <a href="https://github.com/Magisk-Modules-Repo/com.piyushgarg.rclone">rclone-mount</a> with bug fixes and newer binaries included. More details in the
    <a href="https://github.com/AvinashReddy3108/rclone-mount-magisk/wiki">wiki</a>.
</div>

<div align="center">
  <h3>
    <a href="https://github.com/AvinashReddy3108/rclone-mount-magisk">
      Source Code
    </a>
    <span> | </span>
    <a href="https://github.com/Magisk-Modules-Repo/com.piyushgarg.rclone">
      Original Module Repository
    </a>
    <span> | </span>
    <a href="https://github.com/rabbits-heart/rclone-mount-magisk/issues">
      Issues
    </a>
  </h3>
</div>

### About
- This magisk module has been created to work with [@itsToggle](https://github.com/itsToggle)'s [Rclone_RD](https://github.com/itsToggle/rclone_RD/) which implements Real-Debrid to rclone. 

- All credit goes to [@itsToggle](https://github.com/itsToggle), [@Howard20181](https://github.com/Howard20181), [@AvinashReddy3108](https://github.com/AvinashReddy3108) and [@piyushgarg](https://github.com/piyushgarg).

# RClone_RD

This RClone Fork contains a Real-Debrid implementation.
Using this version, the entire RealDebrid /torrents directory can be served as a read-only virtual drive. 

A potential use-case for this is serving the /torrent directory over plex, allowing you to build a media library truly unlimted in size. Im working on a project that allows plex to function the same way that Wako,Syncler and other streaming apps do. Check it out on https://github.com/itsToggle/plex_rd

### Capabilities and Limitations:

- Read/Write capabilities are limited to reading files and deleting them. 
- This rclone fork will automatically sort your torrents into 3 subfolder: "shows", "movies" and "default". If a torrent couldnt be classified as a movie or a show, you can find it in the "default" folder.
- There are no server-side traffic or storage limitations.
- This rclone fork will automatically re-activate direct links when they expire after 1 week.
- There is a server-side connection limit, which I believe is 16 parallel connections.

# Rclone Magisk Module

### Features
- Support for arm, arm64, & x86 (64bit too)
- Huge list of [supported cloud storage providers](https://rclone.org/#providers)
- Apps with ability to specify paths can access the remotes at `/mnt/cloud/`.
- Most file explorers work just fine ([read more on this](https://github.com/Magisk-Modules-Repo/com.piyushgarg.rclone/issues/9)).
- Mount points use names of remote(s) in rclone.conf
- Specify custom rclone params for each remote via `/sdcard/.rclone/.REMOTE.param`
- Access remotes via HTTP or (S)FTP clients, or bind the remotes to `/sdcard/Cloud/REMOTE` (recommended to [read this](https://github.com/Magisk-Modules-Repo/com.piyushgarg.rclone/issues/5)).
- Support for Work Profiles.

### Configuration
1. Copy your `rclone.conf` file (if you have one already) to `/sdcard/.rclone/rclone.conf` (can always be generated later.)
2. Add custom params at `/sdcard/.rclone/.[global/REMOTE].param` (if needed)
3. Install the module via Magisk Manager
4. Run `rclone config` via term if additional setup required
4. All your rclone mount points will show up under `/mnt/cloud/` & `/storage/cloud/` or `/sdcard/cloud/`

For more detailed configuration of rclone please refer to [official documentation](https://rclone.org)

### Known Issues
- VLC  takes a long time to load media as it opens file in write mode when using it's internal browser.

   a. Create remote type alias for media dirs in rclone.conf and
specify `CACHEMODE=off` in `/sdcard/.rclone/.ALIASNAME.param`

- Encrypted devices can not mount until unlock
- Encrypted `rclone.conf` causes reboots
- High cpu/mem in some apps with storage perms ([issue #9](https://github.com/Magisk-Modules-Repo/com.piyushgarg.rclone/issues/9))
- The `fusermount` bin may not be compatible on all devices (see [thread](https://www.google.com/amp/s/forum.xda-developers.com/android/development/fusermount-android-rclone-mount-t3866652/amp/))

## Disclaimer
- Neither the author nor devs will be held responsible for any damage/data loss that may occur during use of this module.
- While we have done our best to make sure no harm will come about, no guarantees can be made.
- Keep in mind the binaries included in this project are BETA quality (at best), which may cause unforseen issues.

Always check this document before updating to new releases as significant changes may occur.

## Credits
- [@itsToggle](https://github.com/itsToggle) for [rclone_RD](https://github.com/itsToggle/rclone_RD/) 
- [@Howard20181](https://github.com/Howard20181), [@AvinashReddy3108](https://github.com/AvinashReddy3108) and [@piyushgarg](https://github.com/piyushgarg) for their original magisk modules
- rclone devs
- pmj_pedro[@xda](https://forum.xda-developers.com/showpost.php?p=78147335&postcount=1)
- agnostic-apollo[@xda](https://forum.xda-developers.com/showpost.php?p=79929083&postcount=12)
- Termux for building and hosting binaries for [rclone](https://packages.termux.org/apt/termux-main/pool/main/r/rclone), [fusermount](https://grimler.se/termux-root-packages-24/pool/stable/libf/libfuse2/), [inotifywait](https://packages.termux.org/apt/termux-main/pool/main/i/inotify-tools), [libandroid-support.so](https://packages.termux.org/apt/termux-main/pool/main/liba/libandroid-support).
- improvements by geofferey@github
- @Zackptg5 for MMT-EX Module template.
