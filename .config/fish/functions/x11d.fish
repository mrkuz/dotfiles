function x11d
  argparse -x s,m 'h/help' 's/share-home' 'm/mount-home' 'k/keep-container' 'n/name=' -- $argv
  if set -q _flag_h
    echo -n "Usage: x11d OPTIONS IMAGE

Options:
  -h, --help
  -k, --keep-container
  -m, --mount-home
  -n, --name
  -s, --share-home
"
    return
  end
  if set -q _flag_s
    set argv -v /home/(id -un):/home/(id -un)/shared/ $argv
  else if set -q _flag_m
    set argv -v /home/(id -un):/home/(id -un)/ $argv
  end
  if not set -q _flag_k
    set argv --rm $argv
  end
  if set -q _flag_n
    set argv --name $_flag_n --hostname $_flag_n $argv
  end

  docker run \
    --user (id -u):(id -g) \
    -ti \
    --security-opt apparmor=unconfined \
    --ipc host \
    --gpus all \
    --device /dev/dri \
    --device /dev/vga_arbiter/ \
    --device /dev/nvidia0 \
    --device /dev/nvidiactl \
    --device /dev/nvidia-modeset \
    --device /dev/nvidia-uvm \
    --device /dev/nvidia-uvm-tools \
    --device /dev/input \
    --device /dev/snd \
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
