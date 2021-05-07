function ubuntu-shell
    set -x user (id -un)
    set -x overlay "/data/overlay/ubuntu/$user"

    function mount-overlay
        if ! mountpoint -q "$overlay/mnt"
            sudo mkdir -p "$overlay/"{mnt,rw,work}
            sudo mount -t overlay overlay -o "lowerdir=/home/$user,upperdir=$overlay/rw,workdir=$overlay/work" "$overlay/mnt"
        end
    end

    function run-docker
        docker run -ti \
            -u (id -un) \
            -v "$overlay/mnt/":/home/(id -un) \
            -v /nix:/nix:ro \
            -v /run/current-system:/run/current-system:ro \
            -e LANG=C.UTF-8 \
            -e LC_ALL=C.UTF-8 \
            $argv \
            mrkuz/ubuntu-shell
        functions -e run-docker
    end

    mount-overlay

    if ! mountpoint -q "$overlay/mnt"
        echo "Mount overlay failed"
        return
    end

    if test -n "$argv[1]"
        set name "$argv[1]"
        docker start -i $name || run-docker -h $name --name $name
    else
        run-docker -h ubuntu-shell --rm
    end
end
