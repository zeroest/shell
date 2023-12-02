
# [Reset](https://git-scm.com/docs/git-reset)

`git reset --[soft | mixed | hard] ${commit_hash}`  
`git reset HEAD^`  
`git reset HEAD~${number}`  

```bash
git log
# * c0df8bb - (HEAD -> main) c (3 seconds ago)<zeroest>
# * bb4fdc4 - b (12 seconds ago)<zeroest>
# * 375ff1b - a (22 seconds ago)<zeroest>

git reset HEAD^
# * bb4fdc4 - (HEAD -> main) b (2 minutes ago)<zeroest>
# * 375ff1b - a (2 minutes ago)<zeroest>

git reset HEAD~2
# * 375ff1b - (HEAD -> main) a (44 seconds ago)<zeroest>

git reset 375ff1b
# * 375ff1b - (HEAD -> main) a (14 minutes ago)<zeroest>

git reset HEAD^ # before commit
git reset HEAD~${number_of_commit}
git reset ${commit_hash}
```

```bash
git reflog
# 3731280 (HEAD -> main) HEAD@{0}: reset: moving to 3731280
# 438e149 HEAD@{1}: commit: c
# fd87400 HEAD@{2}: commit: b
# 3731280 (HEAD -> main) HEAD@{3}: commit (initial): a

git reset 438e149
* 438e149 - (HEAD -> main) c (2 minutes ago)<zeroest>
* fd87400 - b (2 minutes ago)<zeroest>
* 3731280 - a (2 minutes ago)<zeroest>
```

# [Revert](https://git-scm.com/docs/git-revert)

특정 commit을 undo하는 새로운 commit 을 forward-moving 해서 만들어 낸다

`git revert ${commit_hash}`  
`git revert HEAD`  
`git revert HEAD^`  
`git revert HEAD~${number}`  
`git revert HEAD~${number}..` (range)  

```bash
git log
# * 438e149 - (HEAD -> main) c (6 minutes ago)<zeroest>
# * fd87400 - b (6 minutes ago)<zeroest>
# * 3731280 - a (6 minutes ago)<zeroest>

git revert HEAD
# [main fa78ab1] Revert "c"
#  1 file changed, 0 insertions(+), 0 deletions(-)
#  delete mode 100644 c

git log
# * 13023b9 - (HEAD -> main) Revert "c" (3 seconds ago)<zeroest>
# * 438e149 - c (6 minutes ago)<zeroest>
# * fd87400 - b (6 minutes ago)<zeroest>
# * 3731280 - a (6 minutes ago)<zeroest>

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  2 23:18 a
# -rw-r--r--@ 1 zero  staff     0B 12  2 23:17 b
```

```bash
git log
# * 438e149 - (HEAD -> main) c (6 minutes ago)<zeroest>
# * fd87400 - b (6 minutes ago)<zeroest>
# * 3731280 - a (6 minutes ago)<zeroest>

$ git revert 3731280
# [main 17a9df2] Revert "a"
#  1 file changed, 0 insertions(+), 0 deletions(-)
#  delete mode 100644 a

git log
# * 17a9df2 - (HEAD -> main) Revert "a" (47 seconds ago)<zeroest>
# * 438e149 - c (11 minutes ago)<zeroest>
# * fd87400 - b (11 minutes ago)<zeroest>
# * 3731280 - a (11 minutes ago)<zeroest>

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  2 23:18 b
# -rw-r--r--@ 1 zero  staff     0B 12  2 23:17 c
```

```bash
git log
# * 438e149 - (HEAD -> main) c (6 minutes ago)<zeroest>
# * fd87400 - b (6 minutes ago)<zeroest>
# * 3731280 - a (6 minutes ago)<zeroest>

<<<
git revert --no-commit 438e149
git revert --no-commit fd87400
git commit -m 'Revert c, b'
# [main a70ba52] Revert c, b
#  2 files changed, 0 insertions(+), 0 deletions(-)
#  delete mode 100644 b
#  delete mode 100644 c
===
# The .. helps create a range. Meaning HEAD~2.. is the same as HEAD~2..HEAD
git revert --no-commit HEAD~2..
git commit -m 'Revert c, b'
# [main b6c76f9] Revert c, b
#  2 files changed, 0 insertions(+), 0 deletions(-)
#  delete mode 100644 b
#  delete mode 100644 c
>>>

git log
# * a70ba52 - (HEAD -> main) Revert c, b (24 seconds ago)<zeroest>
# * 438e149 - c (15 minutes ago)<zeroest>
# * fd87400 - b (16 minutes ago)<zeroest>
# * 3731280 - a (16 minutes ago)<zeroest>

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  2 23:22 a
```
