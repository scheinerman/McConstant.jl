module McConstant
using Memoize
export mc_possible, mc_constant


function nug_check(nugs...)::Nothing
    if length(nugs) == 0
        error("No nugget sizes specified")
    end

    if minimum(nugs) <= 0
        error("Nugget sizes must be positive")
    end

    nothing
end


"""
    mc_possible(n::Int, nugs...)::Bool
    mc_possible(n::Int)::Bool

Determine if it is possible to purchase `n` McNuggets given
the serving sizes specified in `nugs`. If no nugget sizes are 
given, this is equivalent to `mc_possible(n,6,9,20)`.

# Example
```
julia> mc_possible(43,6,9,20)
false

julia> mc_possible(44,6,9,20)
true
```
"""
@memoize function mc_possible(n::Int, nugs...)::Bool


    if length(nugs) != length(unique(nugs))
        @warn "Repeated nugget size: $nugs"
    end


    nug_check(nugs...)

    sorted_nugs = sort(collect(nugs), rev = true)
    nugs = tuple(sorted_nugs...)

    mc_possible_work(n, nugs...)
end

mc_possible(n::Int) = mc_possible(n, 6, 9, 20)

@memoize function mc_possible_work(n::Int, nugs...)::Bool
    if n == 0
        return true
    end
    if n < nugs[end]
        return false
    end

    for s ∈ nugs
        if mc_possible_work(n - s, nugs...)
            return true
        end
    end

    return false
end


function streak(n::Int, nugs...)::Bool
    s_min = minimum(nugs)
    list = [mc_possible(k, nugs...) for k = n:n+s_min-1]
    return all(list)
end

"""
    mc_constant()::Int
    mc_constant(nugs...)::Int

Calculate the McConstant, i.e., the largest number of Chicken McNuggets
that one cannot purchase. With no arguments, return `mc_constant(6,9,20)`.
"""
function mc_constant(nugs...)::Int

    d = gcd(nugs...)
    if d > 1
        error("Nugget sizes have a common divisor $d; gcd should be 1")
    end

    if minimum(nugs) == 1
        error("Nugget sizes must all be greater than 1")
    end

    n = 1
    while true
        if !mc_possible(n, nugs...) && streak(n + 1, nugs...)
            return n
        end
        n += 1
    end
    0  # this shouldn't happen
end

mc_constant() = mc_constant(6, 9, 20)

end #end of module
