
# [Cherry-pick](https://git-scm.com/docs/git-cherry-pick)

다른 브랜치에 있는 커밋을 선택적으로 내 브랜치에 적용

`git cherry-pick ${commit_hash} [commit_hash] ...`  

`git cherry-pick --continue`  
`git cherry-pick --abort`

```bash
git log
# * 630d929 - (49 seconds ago) c - zeroest (main)
# | -> touch c
# | * 1c76c52 - (69 seconds ago) b - zeroest (HEAD -> f1)
# | | -> touch b
# |/
# * 8961286 - (3 minutes ago) a - zeroest
# -> touch a

git cherry-pick 630d929
# [f1 14ad4f3] c
#  Date: Sun Dec 3 00:09:30 2023 +0900
#  1 file changed, 0 insertions(+), 0 deletions(-)
#  create mode 100644 c

git log
# * 14ad4f3 - (2 minutes ago) c - zeroest (HEAD -> f1)
# * 1c76c52 - (3 minutes ago) b - zeroest
# | * 630d929 - (2 minutes ago) c - zeroest (main)
# |/
# * 8961286 - (4 minutes ago) a - zeroest

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:07 a
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:10 b
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:11 c
```

## Cherry-pick merge commit

`git cherry-pick -m 1 ${commit_hash}`

-m means the parent number.

From the git doc:
> Usually you cannot cherry-pick a merge because you do not know which side of the merge should be considered the mainline.  
> This option specifies the parent number (starting from 1) of the mainline and allows cherry-pick to replay the change relative to the specified parent.

For example, if your commit tree is like below:

```
- A - D - E - F -   master
  \     /
  B - C           branch one
```
then `git cherry-pick E` will produce the issue you faced.  
`git cherry-pick E -m 1` means using `D-E`, while `git cherry-pick E -m 2` means using `B-C-E`.  

[[refer] Explain cherry-pick, with merge commit](https://stackoverflow.com/questions/9229301/git-cherry-pick-says-38c74d-is-a-merge-but-no-m-option-was-given/53693507#53693507)

```bash
git log
# * 3948362 - (8 minutes ago) f - zeroest (main)
# *   292def7 - (8 minutes ago) e - zeroest
# |\
# | * 7f05a59 - (10 minutes ago) c - zeroest (one)
# | * 5517b2e - (10 minutes ago) b - zeroest
# * | c5dd769 - (11 minutes ago) d - zeroest
# |/
# * d71490d - (12 minutes ago) a - zeroest (HEAD -> two)

git cherry-pick 292def7
# error: commit 292def774d6949e9d517bdd3e620af3629b55e42 is a merge but no -m option was given.
# fatal: cherry-pick failed

<<<
git cherry-pick -m 1 292def7
# [two 5407015] e
#  Date: Sun Dec 3 00:34:33 2023 +0900
#  2 files changed, 0 insertions(+), 0 deletions(-)
#  create mode 100644 b
#  create mode 100644 c

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:30 a
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:43 b
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:43 c

git log
# * 5407015 - (10 minutes ago) e - zeroest (HEAD -> two)
# | * 3948362 - (10 minutes ago) f - zeroest (main)
# | *   292def7 - (10 minutes ago) e - zeroest
# | |\
# | | * 7f05a59 - (12 minutes ago) c - zeroest (one)
# | | * 5517b2e - (12 minutes ago) b - zeroest
# | |/
# |/|
# | * c5dd769 - (14 minutes ago) d - zeroest
# |/
# * d71490d - (14 minutes ago) a - zeroest
===
git cherry-pick -m 2 292def7
# [two 3aeba36] e
#  Date: Sun Dec 3 00:34:33 2023 +0900
#  1 file changed, 0 insertions(+), 0 deletions(-)
#  create mode 100644 d

ll
# total 0
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:30 a
# -rw-r--r--@ 1 zero  staff     0B 12  3 00:46 d

git log
# * 3aeba36 - (13 minutes ago) e - zeroest (HEAD -> two)
# | * 3948362 - (13 minutes ago) f - zeroest (main)
# | *   292def7 - (13 minutes ago) e - zeroest
# | |\
# | | * 7f05a59 - (14 minutes ago) c - zeroest (one)
# | | * 5517b2e - (14 minutes ago) b - zeroest
# | |/
# |/|
# | * c5dd769 - (16 minutes ago) d - zeroest
# |/
# * d71490d - (16 minutes ago) a - zeroest
>>>
```
