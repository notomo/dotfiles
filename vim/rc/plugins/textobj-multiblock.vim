omap aj <Plug>(textobj-multiblock-a)
omap ij <Plug>(textobj-multiblock-i)
xmap aj <Plug>(textobj-multiblock-a)
xmap ij <Plug>(textobj-multiblock-i)
let g:textobj_multiblock_blocks = [
    \ [ '(', ')' ],
    \ [ '[', ']' ],
    \ [ '{', '}' ],
    \ [ '<', '>' ],
    \ [ '"', '"'],
    \ [ "'", "'"],
    \ [ '`', '`', 1],
\ ]
