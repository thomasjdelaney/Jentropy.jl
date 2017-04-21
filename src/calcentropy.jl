"""
calcentropy \\

Calculates the requested entropies using the x and y variables given. \\
Arguments:  x = random variable, usually input \\
            y = random variable, usually output/classification \\
            xdims = [number of variables in x, the maximum number of possible values across the dimensions in x] \\
            ydims = [number of variables in y, the maximum number of possible values across the dimensions in y] \\
            calc = The entropies to calculate ex: ["HX", "HXY"] \\
            method = sampling bias correction method ex: "pt" \\
            sampling = method for sampling ex: "naive" \\
Returns:    dictionary, entropies listed in calc => the entropy values \\
"""

function calcentropy(x::Array{Int}, y::Array{Int}, xdims::Array{Int, 1}, ydims::Array{Int, 1}, calc::Array{String, 1}, method::String, sampling::String; base::Int=2)
  xn, xmax = xdims
  yn, ymax = ydims
  x = atleast2d(x)
  y = atleast2d(y)
  checkinputs(x, y, xmax, ymax, xn, yn)
  probs = requireprobs(x, xn, xmax, y, yn, ymax, calc, sampling)
  return requireents(probs, calc, base=base)
end

function calcentropy(x::Array{Int}, xdims::Array{Int, 1}, calc::Array{String, 1}, method::String, sampling::String; base::Int=2)
  xn, xmax = xdims
  x = atleast2d(x)
  checkinputs(x, xmax, xn)
  x_dist_dim = xmax ^ xn
  probs = Dict{String, Array{Float64}}("PX" => prob(decimalise(x, xn, xmax), x_dist_dim, sampling))
  return requireents(probs, calc, base=base)
end
