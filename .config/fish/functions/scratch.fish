function scratch
  if test -n "$argv[1]"
    set name "$argv[1]"
    docker start -i $name || x11d --hostname $name -ti --name $name mrkuz/ubuntu-base
  else
    x11d --hostname scratch -ti --rm mrkuz/ubuntu-base
  end
end
