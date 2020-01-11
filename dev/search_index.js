var documenterSearchIndex = {"docs":
[{"location":"index.html#","page":"Home","title":"Home","text":"CurrentModule = VisualStringDistances","category":"page"},{"location":"index.html#VisualStringDistances-1","page":"Home","title":"VisualStringDistances","text":"","category":"section"},{"location":"index.html#","page":"Home","title":"Home","text":"","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"Modules = [VisualStringDistances]","category":"page"},{"location":"index.html#VisualStringDistances.Glyph","page":"Home","title":"VisualStringDistances.Glyph","text":"Glyph <: AbstractArray{Bool,2}\n\nHolds the bitmap associated to a Unifont glyph in a packed format.\n\n\n\n\n\n","category":"type"},{"location":"index.html#VisualStringDistances.Glyph-Tuple{String}","page":"Home","title":"VisualStringDistances.Glyph","text":"Glyph(s::String) --> Glyph\n\nConstruct a Glyph from a string.\n\nExamples\n\njulia> Glyph(\"abc\")\n------------------------\n------------------------\n------------------------\n---------#--------------\n---------#--------------\n---------#--------------\n--####---#-###----####--\n-#----#--##---#--#----#-\n------#--#----#--#------\n--#####--#----#--#------\n-#----#--#----#--#------\n-#----#--#----#--#------\n-#---##--##---#--#----#-\n--###-#--#-###----####--\n------------------------\n------------------------\n\n\n\n\n\n","category":"method"},{"location":"index.html#VisualStringDistances.GlyphCoordinates","page":"Home","title":"VisualStringDistances.GlyphCoordinates","text":"GlyphCoordinates{T} <: AbstractVector{T}\n\nA sparse representation of a Glyph.\n\n\n\n\n\n","category":"type"},{"location":"index.html#VisualStringDistances.glyph!-Tuple{Array{UInt8,1}}","page":"Home","title":"VisualStringDistances.glyph!","text":"glyph!(v::Vector{UInt8}) -> Glyph\n\nCreates a Glyph for a vector of bytes, assuming the vector represents a single Unifont character. Modifies v and may share its memory.\n\n\n\n\n\n","category":"method"}]
}
