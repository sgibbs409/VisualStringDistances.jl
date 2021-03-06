"""
    Glyph <: AbstractArray{Bool,2}

Holds the bitmap associated to a Unifont glyph in a packed format.
"""
struct Glyph <: AbstractArray{Bool,2}
    data::Matrix{UInt8}
end

Base.size(A::Glyph) = (size(A.data, 1), size(A.data, 2) * 8)

function Base.getindex(A::Glyph, i::Int, j::Int)
    block = A.data[i, cld(j, 8)]
    k = (j - 1) % 8
    Bool((block >> k) & 1)
end

Base.hcat(a::Glyph, b::Glyph) = Glyph(hcat(a.data, b.data))

# https://discourse.julialang.org/t/convert-integer-to-bits-array/26663/7
function revbits(z::UInt8)
    z = (((z & 0xaa) >> 1) | ((z & 0x55) << 1))
    z = (((z & 0xcc) >> 2) | ((z & 0x33) << 2))
    z = (((z & 0xf0) >> 4) | ((z & 0x0f) << 4))
    return z
end

"""
    glyph!(v::Vector{UInt8}) -> Glyph

Creates a [`Glyph`](@ref) for a vector of bytes, assuming the vector represents a single Unifont character. Modifies `v` and may share its memory.
"""
function glyph!(v::Vector{UInt8})
    v .= revbits.(v)
    if length(v) == 16
        Glyph(reshape(v, 16, 1))
    elseif length(v) == 32
        Glyph(transpose(reshape(v, 2, 16)))
    else
        throw(ArgumentError("Input vector must have length 16 or 32, corresponding to a single character."))
    end
end

const UNIFONT_LOOKUP = let file = readdlm(joinpath(@__DIR__, "..", "data",
                                                   "unifont-12.1.04.hex"), ':', String)
    Dict{String,String}(r[1] => r[2] for r in eachrow(file))
end

const GLYPH_CHAR_CACHE = Dict{Char,Glyph}()

function key(c::Char)
    u = codepoint(c)
    return uppercase(string(u, base=16, pad=u ≤ 0xffff ? 4 : 6))
end

function get_char(k::AbstractString)
    Char(parse(UInt16, "0x$k"))
end

function Glyph(c::Char)
    get!(GLYPH_CHAR_CACHE, c) do
        k = key(c)
        haskey(UNIFONT_LOOKUP, k) || error("UNIFONT doesn't know how to render `c`.")
        return glyph!(hex2bytes(UNIFONT_LOOKUP[k]))
    end
end

"""
    Glyph(s::AbstractString) --> Glyph

Construct a `Glyph` from a string.

# Examples

```julia-repl
julia> Glyph("abc")
------------------------
------------------------
------------------------
---------#--------------
---------#--------------
---------#--------------
--####---#-###----####--
-#----#--##---#--#----#-
------#--#----#--#------
--#####--#----#--#------
-#----#--#----#--#------
-#----#--#----#--#------
-#---##--##---#--#----#-
--###-#--#-###----####--
------------------------
------------------------
```
"""
function Glyph(s::AbstractString)
    foldl(hcat, (Glyph(c) for c in s))
end

"""
    printglyph([io=stdout], g::Union{Char, AbstractString, Glyph})

Prints a visual representation of `g` to `io`.
"""
function printglyph end

function printglyph(io::IO, g::Glyph; symbols=("#", " "))
    rep = s -> s ? symbols[1] : symbols[2]
    for r in eachrow(g)
        println(io, mapreduce(rep, *, r))
    end
end

printglyph(g; kwargs...) = printglyph(stdout, g; kwargs...)
printglyph(io::IO, s::Union{Char, AbstractString}; kwargs...) = printglyph(io, Glyph(s); kwargs...)
printglyph(s::Union{Char, AbstractString}; kwargs...) = printglyph(stdout, s; kwargs...)

# Base.show(io::IO, ::MIME"text/plain", g::Glyph) = printglyph(io, g)
# Base.show(io::IO, g::Glyph) = printglyph(io, g)
