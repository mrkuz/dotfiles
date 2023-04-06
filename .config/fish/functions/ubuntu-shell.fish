function ubuntu-shell
    set -x user (id -un)
    set -x uid (id -u)
    set -x home "/data/overlays/home/mnt/$user/"

    function run-podman
        podman run -ti \
            -u "$user" \
            --userns keep-id \
            -v "$home":"/home/$user" \
            # nixos
            -v /nix:/nix:ro \
            -v /run/current-system:/run/current-system:ro \
            -e PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/$user/.nix-profile/bin:/run/current-system/sw/bin" \
            -e XDG_DATA_DIRS="$XDG_DATA_DIRS" \
            -e XDG_CONFIG_DIRS="$XDG_CONFIG_DIRS" \
            # locales
            -e LANG=C.UTF-8 \
            -e LC_ALL=C.UTF-8 \
            # x11
            --ipc=host \
            -e DISPLAY="$DISPLAY" \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            # wayland
            -e XDG_SESSION_TYPE=wayland \
            -e XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
            -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
            -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY":"/$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" \
            # dbus
            -e DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
            -v "$XDG_RUNTIME_DIR/bus":"$XDG_RUNTIME_DIR/bus" \
            -v "$XDG_RUNTIME_DIR/at-spi/bus":"$XDG_RUNTIME_DIR/at-spi/bus" \
            # sound
            --group-add (getent group audio | cut -d: -f3) \
            --device /dev/snd \
            -v "$XDG_RUNTIME_DIR/pulse/native":"$XDG_RUNTIME_DIR/pulse/native" \
            # graphics
            --group-add (getent group video | cut -d: -f3) \
            --group-add (getent group render | cut -d: -f3) \
            --device /dev/dri \
            --device /dev/vga_arbiter \
            $argv \
            mrkuz/ubuntu-shell
        functions -e run-podman
    end

    if test -n "$argv[1]"
        set name "$argv[1]"
        podman start -i $name || run-podman -h $name --name $name
    else
        run-podman -h ubuntu-shell --rm
    end
end
