using StreamMacros
using DiffEqBase
using StaticArrays
using Test

@testset "StreamMacros.jl" begin
    bickley = @velo_from_stream stream begin
      stream = psi₀ + psi₁
      psi₀   = - U₀ * L₀ * tanh(y / L₀)
      psi₁   =   U₀ * L₀ * sech(y / L₀)^2 * re_sum_term

      re_sum_term =  Σ₁ + Σ₂ + Σ₃

      Σ₁  =  ε₁ * cos(k₁*(x - c₁*t))
      Σ₂  =  ε₂ * cos(k₂*(x - c₂*t))
      Σ₃  =  ε₃ * cos(k₃*(x - c₃*t))

      k₁ = 2/r₀      ; k₂ = 4/r₀    ; k₃ = 6/r₀

      ε₁ = 0.0075    ; ε₂ = 0.15    ; ε₃ = 0.3
      c₂ = 0.205U₀   ; c₃ = 0.461U₀ ; c₁ = c₃ + (√5-1)*(c₂-c₃)

      U₀ = 62.66e-6  ; L₀ = 1770e-3 ; r₀ = 6371e-3
    end
    @test bickley isa ODEFunction
    @test bickley(SVector(0.0,0.0), nothing, 0.0) isa SVector

    bickley2 = @var_velo_from_stream stream begin
      stream = psi₀ + psi₁
      psi₀   = - U₀ * L₀ * tanh(y / L₀)
      psi₁   =   U₀ * L₀ * sech(y / L₀)^2 * re_sum_term

      re_sum_term =  Σ₁ + Σ₂ + Σ₃

      Σ₁  =  ε₁ * cos(k₁*(x - c₁*t))
      Σ₂  =  ε₂ * cos(k₂*(x - c₂*t))
      Σ₃  =  ε₃ * cos(k₃*(x - c₃*t))

      k₁ = 2/r₀      ; k₂ = 4/r₀    ; k₃ = 6/r₀

      ε₁ = 0.0075    ; ε₂ = 0.15    ; ε₃ = 0.3
      c₂ = 0.205U₀   ; c₃ = 0.461U₀ ; c₁ = c₃ + (√5-1)*(c₂-c₃)

      U₀ = 62.66e-6  ; L₀ = 1770e-3 ; r₀ = 6371e-3
    end
    @test bickley2 isa ODEFunction  
    @test (bickley2(SMatrix{2,3}(0.0,0.0,0.0,0.0,0.0,0.0), nothing, 0.0) 
           isa SMatrix{2,3})

    @test StreamMacros.expr_diff(:(x^2 + sin(x) + y), :x) == :(2x + cos(x))

    # Write your own tests here.
end
