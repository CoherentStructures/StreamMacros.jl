# (c) 2018 Alvaro de Diego, Daniel Karrasch & Nathanael Schilling

# Bickley jet flow [Rypina et al., 2010]
@define_stream ψ_bickley begin
    ψ_bickley = ψ₀ + ψ₁
    ψ₀ = - U₀ * L₀ * tanh(y / L₀)
    ψ₁ =   U₀ * L₀ * sech(y / L₀)^2 * re_sum_term

    re_sum_term = Σ₁ + Σ₂ + Σ₃

    Σ₁ = ε₁ * cos(k₁*(x - c₁*t))
    Σ₂ = ε₂ * cos(k₂*(x - c₂*t))
    Σ₃ = ε₃ * cos(k₃*(x - c₃*t))

    k₁ = 2/r₀    ; k₂ = 4/r₀   ; k₃ = 6/r₀

    ε₁ = 0.0075  ; ε₂ = 0.15   ; ε₃ = 0.3
    c₂ = 0.205U₀ ; c₃ = 0.461U₀; c₁ = c₃ + (√5-1)*(c₂-c₃)
    U₀ = 62.66e-6; L₀ = 1770e-3; r₀ = 6371e-3
end
bickleyJet = @velo_from_stream ψ_bickley
bickleyJet! = @velo!_from_stream ψ_bickley
bickleyJetEqVari = @var_velo_from_stream ψ_bickley
bickleyJetEqVari! = @var_velo!_from_stream ψ_bickley

# rotating double gyre flow  [Mosovsky & Meiss, 2011]
@define_stream Ψ_rot_dgyre begin
    st          = heaviside(t)*heaviside(1-t)*t^2*(3-2*t) + heaviside(t-1)
    heaviside(x)= 0.5*(sign(x) + 1)
    Ψ_P         = sin(2π*x)*sin(π*y)
    Ψ_F         = sin(π*x)*sin(2π*y)
    Ψ_rot_dgyre = (1-st) * Ψ_P + st * Ψ_F
end
rot_double_gyre = @velo_from_stream Ψ_rot_dgyre
rot_double_gyre! = @velo!_from_stream Ψ_rot_dgyre
rot_double_gyreEqVari = @var_velo_from_stream Ψ_rot_dgyre
rot_double_gyreEqVari! = @var_velo!_from_stream Ψ_rot_dgyre
