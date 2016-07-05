# For calculating the required entropies

function requireents(probs::Dict{ASCIIString, Array{Float64}}, calc::Array{ASCIIString, 1})
  ents = Dict{ASCIIString, Float64}()
  in("HX", calc) && (ents["HX"] = entropy(probs["PX"], 2))
  in("HY", calc) && (ents["HX"] = entropy(probs["PY"], 2))
  in("HXY", calc) && (ents["HXY"] = condEntropy(PY, PXY, 2))
  return ents
end
