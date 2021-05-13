#!/usr/bin/env bash

readonly MIN_CHARS=3
readonly BUFFER="parse-buffer"

pane="$1"
mode="$2"
cwd="$3"

if [[ "$mode" != "stage-2" ]]; then
    cwd="$PWD"
    # We store PWD of the pane in a file (see ~/.config/fish/config.fish)
    if [[ -f ~/.tmp/tmux/pwd/${pane#%} ]]; then
      cwd=$(< ~/.tmp/tmux/pwd/${pane#%})
    fi
    tmux split-window -v -l 10 "tmux setw remain-on-exit off; $0 $1 stage-2 $cwd"
    exit 0
fi


tmux capture-pane -b "$BUFFER" -t "$pane"

# First select line
mapfile -t lines <<< $(tmux show-buffer -b "$BUFFER")
tmux delete-buffer -b "$BUFFER"

declare -A processed
filtered=()
for i in "${!lines[@]}"; do
    line="${lines[$i]}"

    # Skip lines below minimun length
    if [[ "${#line}" -lt $MIN_CHARS ]]; then
        continue
    fi

    # Only process once
    hash=$(md5sum <<< $line)
    if [[ ${processed["$hash"]} == "1" ]]; then
        continue
    fi
    processed["$hash"]="1"

    index=$((${#filtered[@]} + 1))
    filtered["$index"]="$line"
done

selected=$(for i in "${filtered[@]}"; do echo $i; done \
    | fzf \
        --print-query \
        --bind=bs:clear-query \
        --tiebreak=index \
        --layout=reverse-list)

mapfile -t selected <<< "$selected"
query="${selected[0]}"
line="${selected[1]}"

# Then create a list of candidates in the line
words=($line)
if [[ "${#words[@]}" == 0 ]]; then
    exit 0
fi

processed=()
filtered=()
for i in "${!words[@]}"; do
    word="${words[$i]}"

    # Skip words below minimun length
    if [[ "${#word}" -lt $MIN_CHARS ]]; then
        continue
    fi

    # Only process once
    hash=$(md5sum <<< $word)
    if [[ ${processed["$hash"]} == "1" ]]; then
        continue
    fi
    processed["$hash"]="1"

    # Skip quoted (needs better handling here)
    if [[ "$word" =~ (^[\'\"]|[\'\"]$) ]]; then
        continue
    fi

    # Skip file sizes
    if [[ "$word" =~ ^[0-9]+(\.[0-9]+)?.B$ ]]; then
        continue
    fi

    index=$((${#filtered[@]} + 1))

    # Hashes
    if [[ "$word" =~ ^[0-9a-f]{6,}$ ]]; then
        filtered["$index"]="h: $word"
        continue
    fi

    # URLs
    if [[ "$word" =~ ^(https?|www\.).*$ ]]; then
        filtered["$index"]="u: $word"
        continue
    fi

    # Absolute paths
    if [[ "$word" =~ ^/ &&  -e "$word" ]]; then
        filtered["$index"]="f: $word"
        continue
    fi

    # Relative paths
    if [[ -e "$cwd/$word" ]]; then
        filtered["$index"]="f: $word"
        continue
    fi

    # Other
    filtered["$index"]="o: $word"
done

if [[ "${#filtered[@]}" == 0 ]]; then
    tmux display-message -d 1000 "No results"
    exit 0
fi

selected=$(for i in "${filtered[@]}"; do echo $i; done \
    | sort \
    | fzf --print-query \
        --query="$query" \
        --preview="echo Enter: Insert; echo Ctrl-O: Open; echo Alt-W: Copy" \
        --bind=bs:clear-query \
        --header="$line" \
        --expect=ctrl-o,alt-w)

mapfile -t selected <<< "$selected"
query="${selected[0]}"
key="${selected[1]}"
result="${selected[2]#*: }"

case "$key" in
    "alt-w")
        xclip -selection clipboard <<< "$result"
        sleep 0.1
        ;;
    "ctrl-o")
        cd "$cwd"
        xdg-open "$result"
        ;;
    *)
        if [[ -n "$result"  ]]; then
            tmux set-buffer -b "$BUFFER" "$result"
        else
            tmux set-buffer -b "$BUFFER" "$query"
        fi
        tmux paste-buffer -b "$BUFFER" -t "$pane"
        ;;
esac

exit 0
