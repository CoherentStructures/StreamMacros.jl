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

    @define_stream test_stream begin
        test_stream = x^2 + y^2
    end

    t1 = @var_velo_from_stream test_stream
    t2 = @velo_from_stream test_stream
    @test t1 isa ODEFunction
    @test t2 isa ODEFunction
    ω = @vorticity_from_stream test_stream
    @test ω(rand(), rand(), rand()) == 4

    @define_stream Ψ_rot_dgyre begin
        st          = window(t, 0, 1)*t^2*(3-2*t) + heaviside(t-1)
        heaviside(x)= 0.5*(sign(x) + 1)
        window(x, a, b) = heaviside(x - a)*heaviside(b - x)
        Ψ_P         = sin(2π*x)*sin(π*y)
        Ψ_F         = sin(π*x)*sin(2π*y)
        Ψ_rot_dgyre = (1-st) * Ψ_P + st * Ψ_F
    end
    rot_double_gyre = @velo_from_stream Ψ_rot_dgyre
    dgyrepast = @velo_from_stream Ψ_P begin
        Ψ_P = sin(2π*x)*sin(π*y)
    end
    @test dgyrepast isa ODEFunction
    dgyrefuture = @velo_from_stream Ψ_F begin
        Ψ_F = sin(π*x)*sin(2π*y)
    end
    @test dgyrefuture isa ODEFunction
    t = eps() + rand()
    x = SVector{2}(rand(2))
    @test rot_double_gyre(x, nothing, -t) == dgyrepast(x, nothing, -t)
    @test rot_double_gyre(x, nothing, 1+t) == dgyrefuture(x, nothing, 1+t)
end
