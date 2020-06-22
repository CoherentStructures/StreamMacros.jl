using Documenter, StreamMacros

makedocs(;
    format = Documenter.HTML(),
    sitename = "StreamMacros.jl",
    modules = [StreamMacros],
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo = "github.com/CoherentStructures/StreamMacros.jl.git",
    push_preview = true,
)
