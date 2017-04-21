"""
checkinputs \\

for checking that the inputs are consistent \\
Arguments:  x = random variable, usually input \\
            y = random variable, usually output/classification \\
            xmax = the maximum number of possible values across the dimensions in x \\
            ymax = the maximum number of possible values across the dimensions in y \\
            xn = number of variables in x \\
            yn = number of variables in y \\
Returns:    nothing
"""

function checkinputs(x::Array{Int}, y::Array{Int}, xmax::Int, ymax::Int, xn::Int, yn::Int)
  maximum(x) >= xmax && error("x values must be between 0 and ", string(xmax), ".")
  maximum(y) >= ymax && error("x values must be between 0 and ", string(ymax), ".")
  size(x)[1] != xn && error("size(x)[1] must equal xn.")
  size(y)[1] != yn && error("size(y)[1] must equal yn.")
  size(x)[2] != size(y)[2] && error("x and y must have the same number of trials.")
  return nothing
end

function checkinputs(x::Array{Int}, xmax::Int, xn::Int)
  maximum(x) >= xmax && error("x values must be between 0 and ", string(xmax), ".")
  size(x)[1] != xn && error("size(x)[1] must equal xn.")
  return nothing
end
