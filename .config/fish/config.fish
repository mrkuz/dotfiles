if status --is-interactive
  set -g EDITOR "nano"
  alias emacs "env SHELL=/bin/bash emacsclient -n -c -a emacs"
  alias docker-purge "docker rm (docker ps -aq)"
  abbr --add --global ga   "git add"
  abbr --add --global gap  "git add -p"
  abbr --add --global gau  "git add -u"
  abbr --add --global gc   "git checkout"
  abbr --add --global gcm  "git checkout master"
  abbr --add --global gcmm "git checkout --"
  abbr --add --global gd   "git diff"
  abbr --add --global gdc  "git diff --cached"
  abbr --add --global gm   "git merge --no-commit"
  abbr --add --global gmm  "git merge --no-commit master"
  abbr --add --global gp   "git push"
  abbr --add --global gpo  "git push -u origin"
  abbr --add --global gP   "git pull"
  abbr --add --global grh  "git reset HEAD"
  abbr --add --global gs   "git status"
  abbr --add --global gka  "gitk --all"
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
