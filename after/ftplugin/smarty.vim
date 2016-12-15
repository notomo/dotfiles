if exists("loaded_matchit")
	let b:match_ignorecase = 1
	let b:match_words = '<:>,' .
	\ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
	\ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
	\ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
	let b:match_words .= ',{if\>:{elseif\>:{else\>:{/if\>,{foreach\>:{foreachelse\>:{/foreach\>'
endif
