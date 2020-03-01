if status --is-interactive
  alias emacs "env SHELL=/bin/bash emacsclient -c -a emacs"
  abbr --add --global gco "git checkout"
  abbr --add --global gs "git status"
  abbr --add --global gd "git diff"
  abbr --add --global gdc "git diff --cached"
  abbr --add --global gpo "git push -u origin"
end

function todo
  if test (count $argv) -eq 0
    echo "Usage: todo TITLE"
  else
    emacsclient -n -c -F '((name . "org-protocol-capture"))' "org-protocol://capture://b/$argv"
  end
end

function note
  if test (count $argv) -eq 0
    echo "Usage: note TITLE"
  else
    emacsclient -n -c -F '((name . "org-protocol-capture"))' "org-protocol://capture://N/$argv"
  end
end
