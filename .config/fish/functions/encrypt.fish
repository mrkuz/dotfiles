function encrypt
    set input "$argv[1]"
    set output "$input.age"
    
    if test -z "$input"
        echo "Usage: encrypt FILE"
        return
    end
    if test -e "$output"
        echo "Backing up exiting $output"
    end

    age -e -r (cat ~/.ssh/id_rsa.pub) -o "$output" "$input"
end
