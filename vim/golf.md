
# Golf

<details>
<summary>Make HTML List</summary>

<a href="https://www.vimgolf.com/challenges/559e6360b6f8bd0f17010b61">559e6360b6f8bd0f17010b61</a>

```
:s;\v(\w*\d),?;\t<li>\1</li>\r;g<CR>
s</ul><Esc>
:t0<CR>
lxZZ

\v - \(\) 이스케이프 제거
\1 - backreference ()그룹 참조
& - :s/패턴/&/ `패턴` 참조
:t - Synonym for copy e.g. yyp == :t.
```
</details>


<details>
<summary>EDN reformat</summary>

<a href="https://www.vimgolf.com/challenges/9v006519507c00000000025a">9v006519507c00000000025a</a>

```
:%s/\v(:\S+)(.*)/\=printf('%-15s%s',submatch(1),submatch(2))<CR>ZZ

\S - non-whitespace character; opposite of \s
:help printf
```
```
:set et<CR>
:set ts=17<CR>
qqf s<Tab><Esc><CR>q
6@qZZ

:set et - tab을 space로 확장설정 (== :set expandtab)
:set ts - tab 인식 칸 수 설정 (== :set tabstop=17)
```
</details>

