function scratch
  if test -n "$argv[1]"
    set name "$argv[1]"
    docker start -i $name || x11d --hostname $name --name $name mrkuz/ubuntu-desktop
  else
    x11d --hostname scratch --rm mrkuz/ubuntu-desktop
  end
end
