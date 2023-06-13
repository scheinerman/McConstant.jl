module McConstant

using Memoize

export mc_possible, mc_constant

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


end # module McConstant
