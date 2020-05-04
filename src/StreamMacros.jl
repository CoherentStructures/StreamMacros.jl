module StreamMacros

using ModelingToolkit: Variable, Differential, simplified_expr,
      expand_derivatives, Expression, Operation, Constant
      
export @define_stream, @velo_from_stream, @var_velo_from_stream,
       @vorticity_from_stream

include("macros.jl")
	
end # module
