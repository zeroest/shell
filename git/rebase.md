
# [Rebase](https://git-scm.com/docs/git-rebase)

```bash
git log
# * 3f935cf - (3 seconds ago) g - zeroest (HEAD -> one)
# * a24fa83 - (14 seconds ago) f - zeroest
# | * ca8efdd - (25 minutes ago) e - zeroest (main)
# | * f254ec6 - (26 minutes ago) d - zeroest
# |/
# * aa98adc - (26 minutes ago) c - zeroest
# * d94a489 - (26 minutes ago) b - zeroest
# * cc48141 - (26 minutes ago) a - zeroest

git rebase main
# Successfully rebased and updated refs/heads/one.

git log
# * daf35bf - (79 seconds ago) g - zeroest (HEAD -> one)
# * c8b98bb - (2 minutes ago) f - zeroest
# * ca8efdd - (27 minutes ago) e - zeroest (main)
# * f254ec6 - (27 minutes ago) d - zeroest
# * aa98adc - (27 minutes ago) c - zeroest
# * d94a489 - (27 minutes ago) b - zeroest
# * cc48141 - (27 minutes ago) a - zeroest
```

## Interactive

`git rebase -i ${commit_hash}` - 수정할 커밋의 직전 커밋

- p, pick <commit> = use commit
- r, reword <commit> = use commit, but edit the commit message
- e, edit <commit> = use commit, but stop for amending
- s, squash <commit> = use commit, but meld into previous commit
- f, fixup [-C | -c] <commit> = like "squash" but keep only the previous commit's log message,  
  unless -C is used, in which case keep only this commit's message;  
  -c is same as -C but opens the editor  
- x, exec <command> = run command (the rest of the line) using shell
- b, break = stop here (continue rebase later with 'git rebase --continue')
- d, drop <commit> = remove commit
- l, label <label> = label current HEAD with a name
- t, reset <label> = reset HEAD to a label
- m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]  
  create a merge commit using the original merge commit's message  
  (or the oneline, if no original merge commit was specified);  
  use -c <commit> to reword the commit message
- u, update-ref <ref> = track a placeholder for the <ref> to be updated to this position in the new commits.  
  The <ref> is updated at the end of the rebase
These lines can be re-ordered; they are executed from top to bottom.
If you remove a line here THAT COMMIT WILL BE LOST.
However, if you remove everything, the rebase will be aborted.

[Git Rebase --Interactive 옵션 알아보기](https://wormwlrm.github.io/2020/09/03/Git-rebase-with-interactive-option.html)

## Rebase squash commits

```bash
git log
# * ca8efdd - (3 seconds ago) e - zeroest (HEAD -> main)
# * f254ec6 - (14 seconds ago) d - zeroest
# * aa98adc - (23 seconds ago) c - zeroest
# * d94a489 - (31 seconds ago) b - zeroest
# * cc48141 - (41 seconds ago) a - zeroest

git rebase -i HEAD~4
# pick d94a489 b
# s aa98adc c
# s f254ec6 d
# pick ca8efdd e
# # Rebase cc48141..ca8efdd onto cc48141 (4 commands)

# [detached HEAD ffb190a] Rebase squash commits b, c, d
#  Date: Sun Dec 3 01:41:21 2023 +0900
#  3 files changed, 0 insertions(+), 0 deletions(-)
#  create mode 100644 b
#  create mode 100644 c
#  create mode 100644 d
# Successfully rebased and updated refs/heads/main.

git log
# * aa84ade - (19 minutes ago) e - zeroest (HEAD -> main)
# * ffb190a - (19 minutes ago) Rebase squash commits b, c, d - zeroest
# * cc48141 - (19 minutes ago) a - zeroest
```
