using Documenter, StreamMacros

makedocs(;
    modules=[StreamMacros],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/CoherentStructures/StreamMacros.jl/blob/{commit}{path}#L{line}",
    sitename="StreamMacros.jl",
    authors="Alvaro de Diego",
    assets=String[],
)

deploydocs(;
    repo="github.com/CoherentStructures/StreamMacros.jl",
)
