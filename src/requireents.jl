# For calculating the required entropies
# Arguments:  probs, dictionary of probabilities
#             calc, the required entropies
# Returns:    ents, dictionary calc => entropy

function requireents(probs::Dict{String, Array{Float64}}, calc::Array{String, 1}; base::Int=2)
  ents = Dict{String, Float64}()
  in("HX", calc) && (ents["HX"] = entropy(probs["PX"], base))
  in("HY", calc) && (ents["HY"] = entropy(probs["PY"], base))
  in("HXY", calc) && (ents["HXY"] = condentropy(probs["PY"], probs["PXY"], base=base))
  return ents
end
