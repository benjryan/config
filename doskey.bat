@echo off
doskey ls=dir $*
doskey mv=move $*
doskey cp=copy $*
doskey cat=type $*
doskey gs=git status
doskey ga=git add $*
doskey gaa=git add -A
doskey guaa=git reset
doskey gmt=git mergetool $*
doskey gdt=git difftool $*
doskey grc=git rebase --continue
doskey gw=git add -A $T git commit -m "wip"
doskey guw=git reset HEAD~
doskey gc=git commit -m $*
doskey gpr=git pull -r
doskey gpu=git push
doskey gl=git log --oneline
