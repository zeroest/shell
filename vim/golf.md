
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

