# StreamMacros.jl

*Convenience macros for defining velocity fields via their stream function.*

[![build status](https://github.com/CoherentStructures/StreamMacros.jl/workflows/CI/badge.svg?branch=master)](https://github.com/CoherentStructures/StreamMacros.jl/actions?query=workflow%3ACI)
[![code coverage](http://codecov.io/github/CoherentStructures/StreamMacros.jl/coverage.svg?branch=master)](http://codecov.io/github/CoherentStructures/StreamMacros.jl?branch=master)
[![stable docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://coherentstructures.github.io/StreamMacros.jl/stable)
[![dev docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://coherentstructures.github.io/StreamMacros.jl/dev)

## Installation

Install by typing

```julia
]add https://github.com/CoherentStructures/StreamMacros.jl.git
```

in the Julia REPL.

## Examples

The basic usage pattern is

```julia
output = @velo_from_stream <stream_name> begin
    <stream_name> = ...
    # additional definitions
end
```

as in

```julia
using StreamMacros

vortex = @velo_from_stream stream begin
    stream = x^2 + y^2 + perturbation(x, y, t)
    perturbation(x, y, t) = sin(t) * y
end
```
