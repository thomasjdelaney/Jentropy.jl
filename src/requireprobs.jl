"""
requireprobs \\

For returning the probabilities required to calculate the entropies \\
Arguments:  x = random variable, usually input \\
            xn = number of variables in x \\
            xmax = the maximum number of possible values across the dimensions in x \\
            y = random variable, usually output/classification \\
            yn = number of variables in y \\
            ymax = the maximum number of possible values across the dimensions in y \\
            calc = The entropies to calculate ex: ["HX", "HXY"] \\
            sampling = method for sampling ex: "naive" \\
Returns:    probs, dictionary probability string => probabilities \\
"""

function requireprobs(x::Array{Int}, xn::Int, xmax::Int, y::Array{Int}, yn::Int, ymax::Int, calc::Array{String, 1}, sampling::String)
  probs = Dict{String, Array{Float64}}()
  dec_x = decimalise(x, xn, xmax)
  dec_y = decimalise(y, yn, ymax)
  x_dist_dim = xmax ^ xn # the dimension of the probability distribution required for x
  y_dist_dim = ymax ^ yn
  reduce(|, [in(ent, calc) for ent in ["HXY" "HY"]]) && (probs["PY"] = prob(dec_y, y_dist_dim, sampling))
  reduce(|, [in(ent, calc) for ent in ["HXY" "HX"]]) && (probs["PX"] = prob(dec_x, x_dist_dim, sampling))
  reduce(|, [in(ent, calc) for ent in ["HXY"]]) && (probs["PXY"] = condprob(dec_x, dec_y, x_dist_dim, y_dist_dim, sampling)[2])
  return probs
end
