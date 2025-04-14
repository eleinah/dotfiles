set brain /home/ellie/git/GitHub/self/obsidian-md/brain
set braintime $(date "+%Y-%m-%d %H:%M:%S")

alias brains "cd $brain; git pull --rebase; git add .; git commit -am "Updated notes $braintime"; git push"
