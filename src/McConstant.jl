module McConstant

using Memoize

export mc_possible, mc_constant, mc_solver, mc_order

"""
    mc_possible(n::Int)::Bool

Determine if it is possible to purchase `n` McNuggets assuming the
sizes available are 6, 9, or 20. Return `true` is possible.

# Example
```
julia> mc_possible(19)
false

julia> mc_possible(21)
true
```
"""
@memoize function mc_possible(n::Int)::Bool
    if n == 0
        return true
    end
    if n < 6
        return false
    end

    if mc_possible(n - 6) || mc_possible(n - 9) || mc_possible(n - 20)
        return true
    end
    return false
end

"""
    streak(n::Int)::Bool

See if there are 6 consecutive `true` returns from `mc_possible` for 
values from `n` to `n+5`.
"""
function streak(n::Int)::Bool
    list = [mc_possible(k) for k = n:n+5]
    return all(list)
end

"""
    mc_constant()::Int

Calculate the McConstant, i.e., the largest number of Chicken McNuggets
that one cannot purchase.
"""
function mc_constant()::Int
    n = 20
    while true
        if !mc_possible(n) && streak(n + 1)
            return n
        end
        n += 1
    end
    0  # this shouldn't happen
end



"""
    mc_solver(n::Int)::Tuple{Int,Int,Int}

Helper function used by `mc_order`. Returns a tuple `(a,b,c)`
that gives the number of six-, nine-, and twenty-piece 
portions to order to get `n` McNuggets. That is,
`6a+9b+20c == n`. 

Throws an error if no order is possible. 

# Example
```
julia> mc_solver(44)
(1, 2, 1)
```
"""
@memoize function mc_solver(n::Int)::Tuple{Int,Int,Int}
    if !mc_possible(n)
        error("Cannot order $n McNuggets")
    end
    if n == 0
        return 0, 0, 0
    end

    if mc_possible(n - 20)
        a, b, c = mc_solver(n - 20)
        return a, b, c + 1
    end

    if mc_possible(n - 9)
        a, b, c = mc_solver(n - 9)
        return a, b + 1, c
    end

    if mc_possible(n - 6)
        a, b, c = mc_solver(n - 6)
        return a + 1, b, c
    end

    error("This can't happen")
end


"""
    mc_order(n::Int)

Explain how to purchase `n` McMuffins.

# Example
```
julia> mc_order(44)
Order 1 six-piece, 2 nine-piece, and 1 twenty-piece
```

"""
function mc_order(n::Int)
    if !mc_possible(n)
        println("It is not possible to order $n McNuggets")
        return
    end

    a, b, c = mc_solver(n)
    println("Order $a six-piece, $b nine-piece, and $c twenty-piece")
end




end # module McConstant
