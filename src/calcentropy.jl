# The calcentropy function itself. Calculates the entropy of the variables given.
# Arguments:  x = random variable, usually input
#             y = random variable, usually output/classification
#             xdims = [length of vector, least upper bound of x (the number of possible values)]
#             ydims = [length of vector, least upper bound of y (the number of possible values)]
#             calc = The entropies to calculate ex: ["HX", "HXY"]
#             method = sampling bias correction method ex: "pt"
#             sampling = method for sampling ex: "naive"
# Returns:

function calcentropy(x::Array{Int}, y::Array{Int}, xdims::Array{Int, 1}, ydims::Array{Int, 1}, calc::Array{String, 1}, method::String, sampling::String)
  # initialising and checking
  xn, xmax = xdims
  yn, ymax = ydims
  x = vec(x)
  y = vec(y)
  checkinputs(x, y, xmax, ymax, xn, yn)
  probs = requireprobs(x, xmax, y, ymax, calc, sampling)
  return requireents(probs, calc)
end

function calcentropy(x::Array{Int}, xdims::Array{Int, 1}, calc::Array{String, 1}, method::String, sampling::String)
  xn, xmax = xdims
  x = vec(x)
  checkinputs(x, xmax, xn)
  probs = Dict{String, Array{Float64}}("PX" => prob(x, xmax, sampling))
  return requireents(probs, calc)
end
