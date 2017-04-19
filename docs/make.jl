push!(LOAD_PATH, homedir() * "/Jentropy.jl/src")
using Documenter, Jentropy

makedocs()
