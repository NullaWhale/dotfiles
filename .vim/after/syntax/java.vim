" Vim additional java syntax file
" File:			java.vim
" Language:		java
" Maintainer:	$Author: shirku $
" Last Change:	$Date: 2005-06-26 18:21:22 +0000 (Sun, 26 Jun 2005) $
" Version:		$Id: java.vim 29 2005-06-26 18:21:22Z shirku $

" define syntax items for folding

" fold /* */ style comments
" NOTE: transparent and keepend are essential for proper functioning
syn region javaCommentBlockFold start=+/\*+ end=+\*/+ fold transparent keepend

" fold user defined sections
syn region javaSectionFold start=+// {{{+ end=+// }}}+ fold transparent keepend

" fold scopes in java
syn region javaBlockFold start="{" end="}" fold transparent

" vim: set ts=4:
