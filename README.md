# StreamMacros.jl
[![Build Status](https://travis-ci.org/CoherentStructures/StreamMacros.jl.svg?branch=master)](https://travis-ci.org/CoherentStructures/StreamMacros.jl)

Provides some convenience macros for defining velocity fields via their stream function.

# Installation
Install by typing

		]add https://github.com/CoherentStructures/StreamMacros.jl

in the Julia REPL.

# Examples
The basic  usage pattern is

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
	stream = x^2 + y^2 + perturbation(x,y,t)
	perturbation(x,y,t) = sin(t) * y
end
```
