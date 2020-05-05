module StreamMacros

import StaticArrays
const SA = StaticArrays

import ModelingToolkit
using ModelingToolkit: Variable, Differential, simplified_expr,
      expand_derivatives, Expression, Operation, Constant

import DiffEqBase 
const ODE=DiffEqBase

export @define_stream, @velo_from_stream, @var_velo_from_stream,
       @vorticity_from_stream

include("macros.jl")
	
end # module
