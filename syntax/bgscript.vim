" Vim syntax file
" Language: BGScript
" Maintainer: Jonathan Fisher
" Latest Revision: Jan 19, 2015

if exists("b:current_syntax")
	finish
endif

" Keywords
syntax keyword basicLanguageKeywords if then while do end procedure dim event
syntax keyword basicLanguageKeywords call return
highlight link basicLanguageKeywords Keyword

" Functions
syntax keyword basicLanguageFunctions const
highlight link basicLanguageFunctions Function

" Comments
syntax match comment "\v#.*$"
highlight link comment Comment

" Strings
syntax region strings start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link strings String

" Numbers
syntax match hex "\v\$[0-9a-fA-F]*"
highlight link hex Constant
