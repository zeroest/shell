
# [Restore](https://git-scm.com/docs/git-restore)

`git restore --source [commit hash] [file name]`  
-> 특정 commit으로 복구  

```bash
git log
# * cdabcc2 - (HEAD -> main) c (53 seconds ago)<zeroest>
# -> echo 'c' > text
# * d8a2903 - b (76 seconds ago)<zeroest>
# -> echo 'b' > text
# * ce68ff2 - a (2 minutes ago)<zeroest>
# -> echo 'a' >> text

git restore --source ce68ff2 text

cat text
# a
```

`git restore --staged [file name]`  
-> Staging에 올린 파일 Unstaging

```bash
echo 'hi' > new.file

git s
# ?? new.file

git add new.file

git s
# A  new.file

git restore --staged new.file

git s
# ?? new.file
```
