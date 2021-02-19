module StreamMacros

import StaticArrays
const SA = StaticArrays

import SymEngine

import DiffEqBase
const ODE = DiffEqBase

export
    @define_stream,
    @velo_from_stream,
    @velo!_from_stream,
    @var_velo_from_stream,
    @var_velo!_from_stream,
    @vorticity_from_stream

include("macros.jl")

end # module
