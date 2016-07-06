# For calculating the required entropies

function requireents(probs::Dict{ASCIIString, Array{Float64}}, calc::Array{ASCIIString, 1})
  ents = Dict{ASCIIString, Float64}()
  in("HX", calc) && (ents["HX"] = entropy(probs["PX"], 2))
  in("HY", calc) && (ents["HY"] = entropy(probs["PY"], 2))
  in("HXY", calc) && (ents["HXY"] = condEntropy(probs["PY"], probs["PXY"], 2))
  return ents
end
