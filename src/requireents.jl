# For calculating the required entropies
# Arguments:  probs, dictionary of probabilities
#             calc, the required entropies
# Returns:    ents, dictionary calc => entropy

function requireents(probs::Dict{String, Array{Float64}}, calc::Array{String, 1})
  ents = Dict{String, Float64}()
  in("HX", calc) && (ents["HX"] = entropy(probs["PX"], 2))
  in("HY", calc) && (ents["HY"] = entropy(probs["PY"], 2))
  in("HXY", calc) && (ents["HXY"] = condentropy(probs["PY"], probs["PXY"], base=2))
  return ents
end
