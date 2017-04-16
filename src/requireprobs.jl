# For returning the probabilities required to calculate the entropies
# Arguments:  x = random variable, usually input
#             y = random variable, usually output/classification
#             xdims = [length of vector, least upper bound of x (the number of possible values)]
#             ydims = [length of vector, least upper bound of y (the number of possible values)]
#             calc = The entropies to calculate ex: ["HX", "HXY"]
#             method = sampling bias correction method ex: "pt"
#             sampling = method for sampling ex: "naive"
# Returns:    probs, dictionary probability string => probabilities

function requireprobs(x::Array{Int}, xmax::Int, y::Array{Int}, ymax::Int, calc::Array{String, 1}, sampling::String)
  probs = Dict{String, Array{Float64}}()
  reduce(|, [in(ent, calc) for ent in ["HXY" "HY"]]) && (probs["PY"] = prob(y, ymax, sampling))
  reduce(|, [in(ent, calc) for ent in ["HXY" "HX"]]) && (probs["PX"] = prob(x, xmax, sampling))
  reduce(|, [in(ent, calc) for ent in ["HXY"]]) && (probs["PXY"] = condprob(x, y, xmax, ymax, sampling)[2])
  return probs
end
