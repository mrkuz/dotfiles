if status --is-interactive
  alias emacs "emacsclient -c -a emacs"
  abbr --add --global gco "git checkout"
  abbr --add --global gs "git status"
  abbr --add --global gd "git diff"
  abbr --add --global gdc "git diff --cached"
  abbr --add --global gpo "git push -u origin"
end
