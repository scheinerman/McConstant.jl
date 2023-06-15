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


## Generalized McNuggets

The functions `mc_possible` and `mc_constant` may be fed alternative portion sizes other than the default 6, 9, and 20.
* `mc_possible(n, nugs...)` determines if it is possible to purchase `n` McNuggets with the portion sizes are given in the trailing arguments.
* `mc_constant(nugs...)` determines the McConstant given the portion sizes in the arguments. 

### Example
```
julia> mc_possible(20,5,9)
true

julia> mc_possible(21,5,9)
false

julia> mc_constant(5,9)
31
```

If McNuggets are sold in packages of 5 and 9, then it is possible to purchase 20 McNuggets, but it is not possible to purchase 21.

Further, it is impossible to purchase 31 McNuggets, but it is possible to purchase
any amount greater than 31. 