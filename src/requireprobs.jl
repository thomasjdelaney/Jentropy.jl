# for returning the probabilities required to calculate the entropies

function requireprobs(x::Array{Int}, xmax::Int, y::Array{Int}, ymax::Int, calc::Array{ASCIIString, 1})
  probs = Dict{ASCIIString, Array{Float64}}()
  reduce(|, [in(ent, calc) for ent in ["HXY" "HY"]]) && (probs["PY"] = prob(y, ymax))
  reduce(|, [in(ent, calc) for ent in ["HXY" "HX"]]) && (probs["PX"] = prob(x, xmax))
  reduce(|, [in(ent, calc) for ent in ["HXY"]]) && (probs["PXY"] = condprob(x, y, xmax, ymax)[2])
  return probs
end
