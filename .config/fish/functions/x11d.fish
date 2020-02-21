function x11d
  docker run \
    --user (id -u):(id -g) \
    -v /data/docker-home/(id -un):/home/(id -un) \
    --security-opt apparmor=unconfined \
    --ipc host \
    --device /dev/dri \
    --device /dev/vga_arbiter/ \
    -e DISPLAY="$DISPLAY" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
    -v /run/user/(id -u)/bus:/run/user/(id -u)/bus \
    -e CUPS_SERVER=/run/cups/cups.sock \
    -v /run/cups/cups.sock:/run/cups/cups.sock \
    -e PULSE_SERVER=unix:/tmp/pulseaudio.socket \
    -e PULSE_COOKIE=/tmp/pulseaudio.cookie \
    -v /run/user/(id -u)/pulse/native:/tmp/pulseaudio.socket $argv
end
