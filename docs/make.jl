using VisualStringDistances
using Documenter

makedocs(;
    modules=[VisualStringDistances],
    authors="Eric P. Hanson",
    repo="https://github.com/sgibbs409/VisualStringDistances.jl/blob/{commit}{path}#L{line}",
    sitename="VisualStringDistances.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://sgibbs409.github.io/VisualStringDistances.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Visualizations" => "visualizations.md",
        "Package names" => "packagenames.md",
    ],
)

deploydocs(;
    repo="github.com/sgibbs409/VisualStringDistances.jl",
)
