omap <expr> i. textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')
xmap <expr> i. textobj#from_regexp#mapexpr('\.\zs.\{-}\ze\.')
omap <expr> a. textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')
xmap <expr> a. textobj#from_regexp#mapexpr('\..\{-1,}\(\.\)\@=')

omap <expr> ix textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')
xmap <expr> ix textobj#from_regexp#mapexpr('\v\*\zs[^*]+\ze\*')
omap <expr> ax textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')
xmap <expr> ax textobj#from_regexp#mapexpr('\*.\{-1,}\(*\)\@=')

omap <expr> i/ textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')
xmap <expr> i/ textobj#from_regexp#mapexpr('/\zs.\{-}\ze/')
omap <expr> a/ textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')
xmap <expr> a/ textobj#from_regexp#mapexpr('/.\{-1,}\(/\)\@=')
