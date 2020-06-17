using Documenter, StreamMacros

makedocs(;
    modules=[StreamMacros],
    format=Documenter.HTML(),
    sitename="StreamMacros.jl",
    pages=[
        "Home" => "index.md",
    ],
    authors="Alvaro de Diego",
)

deploydocs(;
    repo="github.com/CoherentStructures/StreamMacros.jl.git",
    push_preview=true,
)
