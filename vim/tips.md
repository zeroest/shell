
## [text-objects](https://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects)

[Vim Text Objects: The Definitive Guide](https://blog.carbonfive.com/vim-text-objects-the-definitive-guide/)

`:help text-object`

[v || d] [i || a] [w | W || t || s || p || b | B]

[v || d]
- v - visual mode
- d - delete

[i || a]
- inner - does not include surrounding white space
- a - includes surrounding white space

[w | W || t || s || p || b | B]
- w - word ( this,is,seven,words, )
- W - WORD ( this,is,one,WORD )
- t - tag
- s - sentence 
- p - paragraph
- b - block ()
- B - block {}
- ohter - {}()<>"'
