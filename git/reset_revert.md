
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

## Revert merge commit

`git revert -m 1 ${commit_hash}`

-m means the parent number.

From the git doc:
> Usually you cannot revert a merge because you do not know which side of the merge should be considered the mainline.  
> This option specifies the parent number (starting from 1) of the mainline and allows revert to reverse the change relative to the specified parent.
>
> Reverting a merge commit declares that you will never want the tree changes brought in by the merge.  
> As a result, later merges will only bring in tree changes introduced by commits that are not ancestors of the previously reverted merge.  
> This may or may not be what you want.
>
> See the [revert-a-faulty-merge How-To](https://github.com/git/git/blob/master/Documentation/howto/revert-a-faulty-merge.txt) for more details.

For example, if your commit tree is like below:

```
- A - D - E - F -   master
  \     /
  B - C           branch one
```
then `git revert E` will produce the issue you faced.  
`git revert E -m 1` means revert `D-E`, while `git revert E -m 2` means revert `B-C-E`.

```bash
git log
# * 3948362 - (31 minutes ago) f - zeroest (HEAD -> main)
# *   292def7 - (31 minutes ago) e - zeroest
# |\
# | * 7f05a59 - (32 minutes ago) c - zeroest (one)
# | * 5517b2e - (33 minutes ago) b - zeroest
# * | c5dd769 - (34 minutes ago) d - zeroest
# |/
# * d71490d - (35 minutes ago) a - zeroest

git revert 292def7
# error: commit 292def774d6949e9d517bdd3e620af3629b55e42 is a merge but no -m option was given.
# fatal: revert failed

<<<
git revert -m 1 292def7
# [main 09d608c] Revert merge commit 292def7 -m 1
#  2 files changed, 0 insertions(+), 0 deletions(-)
#  delete mode 100644 b
#  delete mode 100644 c

git log
# * 09d608c - (2 minutes ago) Revert merge commit 292def7 -m 1 - zeroest (HEAD -> main)
# * 3948362 - (35 minutes ago) f - zeroest
# *   292def7 - (35 minutes ago) e - zeroest
# |\
# | * 7f05a59 - (37 minutes ago) c - zeroest (one)
# | * 5517b2e - (37 minutes ago) b - zeroest
# * | c5dd769 - (38 minutes ago) d - zeroest
# |/
# * d71490d - (39 minutes ago) a - zeroest

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:30 a
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:57 d
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:57 f
===
git revert -m 2 292def7
# [main 61e88a8] Revert merge commit 292def7 -m 2
#  1 file changed, 0 insertions(+), 0 deletions(-)
#  delete mode 100644 d

git log
# * 61e88a8 - (44 seconds ago) Revert merge commit 292def7 -m 2 - zeroest (HEAD -> main)
# * 3948362 - (39 minutes ago) f - zeroest
# *   292def7 - (39 minutes ago) e - zeroest
# |\
# | * 7f05a59 - (41 minutes ago) c - zeroest (one)
# | * 5517b2e - (41 minutes ago) b - zeroest
# * | c5dd769 - (43 minutes ago) d - zeroest
# |/
# * d71490d - (43 minutes ago) a - zeroest

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:30 a
# -rw-r--r--@ 1 zero  staff     0B 12  3 01:12 b
# -rw-r--r--@ 1 zero  staff     0B 12  3 01:12 c
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:57 f
>>>
```
