# McConstant
Compute the largest number of McNuggets that cannot be purchased.

## Buying McNuggets 

Assuming that McDonalds sells Chicken McNuggets in portions of size 6, 9, or 20
it is possible (for example) to purchase exactly 21 McNuggets (buy 6+6+9) but it 
is not possible to purchase exactly 22 McNuggets. 

The function `mc_possible` returns `true` if it is possible to purchase that quantity
of McNuggest, and false otherwise:
```
julia> mc_possible(21)
true

julia> mc_possible(22)
false
```

## The McConstant

The McConstant is defined as the largest number of McNuggets that cannot be purchased. The function `mc_constant` calculates that number:
```
julia> mc_constant()
43
```

This means that it is impossible to purchase exactly 43 McNuggets, but for any value of `n` greater than 43, it is possible to purchase exactly `n` McNuggets. 

## Why?

Because I was bored. Also, I'm not sure that six, nine, and twenty piece servings are
correct. I think this was correct at some point, but may not be any more?

## To Do

For values of `n` for which purchasing `n` McNuggets is possible, have a function that
returns an explanation of how many of each size one needs. 
