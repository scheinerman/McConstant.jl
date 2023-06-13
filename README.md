# `McConstant`
What is the largest number of McNuggets that cannot be purchased?

## Buying McNuggets 

Assuming that McDonalds sells Chicken McNuggets in portions of size 6, 9, or 20
it is possible (for example) to purchase exactly 21 McNuggets (buy 6+6+9) but it 
is not possible to purchase exactly 22 McNuggets. 

The function `mc_possible` returns `true` if it is possible to purchase that quantity
of McNuggets, and false otherwise:
```
julia> using McConstant

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

## How to order

The function `mc_order` returns instructions on how to order `n` McNuggets.
```
julia> mc_order(44)
Order 1 six-piece, 2 nine-piece, and 1 twenty-piece

julia> mc_order(43)
It is not possible to order 43 McNuggets

julia> mc_order(888)
Order 2 six-piece, 4 nine-piece, and 42 twenty-piece
```

The `mc_order` function invokes the `mc_solver` function that returns a tuple `(a,b,c)` showing how many
of each size to order. That is, `6a + 9b + 20c == n`. Throws an error if `n` is not orderable. 
```
julia> mc_solver(44)
(1, 2, 1)

julia> mc_solver(43)
ERROR: Cannot order 43 McNuggets
```



## Why?

Because I was bored. Also, I'm not sure that six, nine, and twenty piece servings are
correct. I think this was correct at some point, but maybe not any more?

## Bugs

This code can't help you if you want to order millions of McNuggets:
```
julia> mc_order(1_000_000)
ERROR: StackOverflowError:
```
But in this case, you have a more serious problem than a stack overflow. 
