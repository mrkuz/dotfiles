function ubuntu-shell
    function run-docker
        docker run -ti \
            -u (id -un) \
            -v /data/overlay/home/mnt/(id -un):/home/(id -un) \
            -v /nix:/nix:ro \
            -v /run/current-system:/run/current-system:ro \
            -e LANG=C.UTF-8 \
            -e LC_ALL=C.UTF-8 \
            $argv \
            mrkuz/ubuntu-shell
        functions -e run-docker
    end

    if test -n "$argv[1]"
        set name "$argv[1]"
        docker start -i $name || run-docker -h $name --name $name
    else
        run-docker -h ubuntu-shell --rm
    end
end
