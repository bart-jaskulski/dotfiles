# shellcheck shell=bash

alias g='git'
alias get='git'

# add
alias ga='git add'
alias gall='git add -A'
alias gap='git add -p'

# branch
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbm='git branch -m'
alias gbt='git branch --track'
alias gdel='git branch -D'

# diff
alias gdf='git diff'
gdfh() {
	git diff $1..HEAD
}

# for-each-ref
alias gbc='git for-each-ref --format="%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)" refs/remotes/ --sort=authorname DESC' # FROM https://stackoverflow.com/a/58623139/10362396

# commit
alias gc='git commit -v'
alias gcv='git commit -v --no-verify'
alias gcaa='git commit -a --amend -C HEAD' # Add uncommitted and unstaged changes to the last commit
alias gcam='git commit -v -am'
alias gca='git commit --amend'
alias gcae='git commit --amend --no-edit'
alias gcaev='git commit --amend --no-edit --no-verify'
alias gcm='git commit -v --message'
alias gcmv='git commit -v --no-verify --message'
alias gci='git commit --interactive'
alias gcsam='git commit -S -am'

# checkout
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcobu='git checkout -b ${USER}/'
alias gup='git fetch && git rebase'

# log
alias gg='git log --graph --pretty=format:'\''%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias gl='git log --oneline'
alias gla='git log --oneline --all'
alias ggf='git log --graph --date=short --pretty=format:'\''%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'\'''
alias ggs='gg --stat'
alias ggup='git log --branches --not --remotes --no-walk --decorate --oneline' # FROM https://stackoverflow.com/questions/39220870/in-git-list-names-of-branches-with-unpushed-commits
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gnew='git log HEAD@{1}..HEAD@{0}' # Show commits since last pull, see http://blogs.atlassian.com/2014/10/advanced-git-aliases/
alias gwc='git whatchanged'

# ls-files
alias gu='git ls-files . --exclude-standard --others' # Show untracked files
alias glsut='gu'
alias glsum='git diff --name-only --diff-filter=U' # Show unmerged (conflicted) files

# home
alias ghm='cd "$(git rev-parse --show-toplevel)"' # Git home

# merge
alias gm='git merge'

# mv
alias gmv='git mv'

# patch
alias gpatch='git format-patch -1'

# push
alias gp='git push'
alias gpd='git push --delete'
alias gpf='git push --force'
alias gpo='git push origin HEAD'
alias gpu='git push --set-upstream'
alias gpunch='git push --force-with-lease'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

# pull
alias gpl='git pull'
alias gpp='git pull && git push'
alias gpr='git pull --rebase'

# remote
alias gr='git remote'
alias gra='git remote add'
alias grv='git remote -v'

# rm
alias grm='git rm'

# rebase
alias grb='git rebase'
alias grc='git rebase --continue'

# reset
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'

# restore
alias grs='git restore --staged'

# status
alias gs='git status'
alias gss='git status -s'

# shortlog
alias gcount='git shortlog -sn'
alias gsl='git shortlog -sn'

# show
alias gsh='git show'

# svn
alias gsd='git svn dcommit'
alias gsr='git svn rebase' # Git SVN

# stash
alias gst='git stash'
alias gstb='git stash branch'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstpo='git stash pop' # recommended for it's symmetry with gstpu (push)
alias gstpu='git stash push'
alias gstm='git stash push -m'

# submodules
alias gsu='git submodule update --init --recursive'

# switch
# these aliases requires git v2.23+
alias gsw='git switch'
alias gswc='git switch --create'
alias gswt='git switch --track'

# tag
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl='git tag -l'

case $OSTYPE in
	darwin*)
		alias gtls="git tag -l | gsort -V"
		;;
	*)
		alias gtls='git tag -l | sort -V'
		;;
esac

# functions
function gdv() {
	git diff --ignore-all-space "$@" | vim -R -
}
