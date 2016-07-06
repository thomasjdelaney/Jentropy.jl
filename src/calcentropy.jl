# The calcentropy function itself

# x = random variable, usually input
# y = random variable, usually output/classification
# xdims = [length of vector, least upper bound of x (the number of possible values)]
# ydims = [length of vector, least upper bound of y (the number of possible values)]
# calc = The entropies to calculate ex: ["HX", "HXY"]
# method = sampling bias correction method ex: "pt"
# sampling = method for sampling ex: "naive"
function calcentropy(x::Array{Int}, y::Array{Int}, xdims::Array{Int, 1}, ydims::Array{Int, 1}, calc::Array{ASCIIString, 1}, method::ASCIIString, sampling::ASCIIString)
  # initialising and checking
  xn, xmax = xdims
  yn, ymax = ydims
  x = atleast2d(x)
  y = atleast2d(y)
  checkinputs(x, y, xmax, ymax, xn, yn)
  probs = requireprobs(x, xmax, y, ymax, calc)
  return requireents(probs, calc)
end