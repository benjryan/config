@echo off
doskey ls=dir $*
doskey mv=move $*
doskey cp=copy $*
doskey cat=type $*
doskey gs=git status
doskey gw=git add -A $T git commit -m "wip"
doskey guw=git reset HEAD~
