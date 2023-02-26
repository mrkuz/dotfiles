function decrypt
    set input "$argv[1]"
    
    if test -z "$input"
        echo "Usage: decrypt FILE"
        return
    end

    age -d -i ~/.ssh/id_rsa "$input"
end
