if status --is-interactive
  set -U fish_greeting
  set -g PATH "$HOME/bin" $PATH
  set -g EDITOR "emacs"
  set -g GIT_EDITOR "nano"
  set -g JAVA_HOME "$HOME/.nix-profile/lib/openjdk/"

  alias docker-purge "docker rm (docker ps -aq)"
  alias kube-clean "kubectl get pods --all-namespaces | grep Evicted | awk '{print \" -n \" \$1 \" \" \$2}' | xargs kubectl delete pod"
  alias copy="xclip -selection clipboard"
  alias paste="xclip -o -selection clipboard"
  alias mvn="JAVA_HOME=$JAVA_HOME command mvn"
  alias strip-ansi="sed 's/\x1b\[[0-9;]*m//g'"

  abbr --add --global ec   "emacsclient -c"
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
  abbr --add --global gP   "git push"
  abbr --add --global gPo  "git push -u origin"
  abbr --add --global gp   "git pull"
  abbr --add --global grh  "git reset HEAD"
  abbr --add --global gs   "git status"
  abbr --add --global gka  "gitk --all"
end
