# StreamMacros.jl

[![Build Status](https://travis-ci.org/CoherentStructures/StreamMacros.jl.svg?branch=master)](https://travis-ci.org/CoherentStructures/StreamMacros.jl)
[![codecov.io](http://codecov.io/github/CoherentStructures/StreamMacros.jl/coverage.svg?branch=master)](http://codecov.io/github/CoherentStructures/StreamMacros.jl?branch=master)
[![coveralls.io](https://coveralls.io/repos/github/CoherentStructures/StreamMacros.jl/badge.svg?branch=master)](https://coveralls.io/github/CoherentStructures/StreamMacros.jl?branch=master)
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://coherentstructures.github.io/StreamMacros.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-latest-blue.svg)](http://coherentstructures.github.io/StreamMacros.jl/latest/)

Provides some convenience macros for defining velocity fields via their stream function.

# Installation
Install by typing

    ]add https://github.com/CoherentStructures/StreamMacros.jl

in the Julia REPL.

# Examples
The basic usage pattern is

```julia
output = @velo_from_stream <stream_name> begin
    <stream_name> = ...
   	# additional definitions
end
```

as in e.g.

```julia
using StreamMacros

vortex = @velo_from_stream stream begin
    stream = x^2 + y^2 + perturbation(x, y, t)
    perturbation(x, y, t) = sin(t) * y
end
```
