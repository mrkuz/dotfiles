function scratch
  if test -n "$argv[1]"
    set name "$argv[1]"
    docker start -i $name || x11d -k -n $name mrkuz/ubuntu-desktop
  else
    x11d -n scratch mrkuz/ubuntu-desktop
  end
end
