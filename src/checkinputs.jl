# for checking that the inputs are consistent
# Arguments:  x = random variable, usually input
#             y = random variable, usually output/classification
#             xmax = least upper bound of x
#             ymax = least upper bound of y
#             xn = length of vector
#             yn = length of vector
# Returns:    nothing

function checkinputs(x::Array{Int}, y::Array{Int}, xmax::Int, ymax::Int, xn::Int, yn::Int)
  maximum(x) >= xmax && error("x values must be between 0 and ", string(xmax), ".")
  maximum(y) >= ymax && error("x values must be between 0 and ", string(ymax), ".")
  length(x) != xn && error("size(x)[1] must equal xn.")
  length(y) != yn && error("size(y)[1] must equal yn.")
  # size(x)[2] != size(y)[2] && error("x and y must have the same number of trials.")
  return nothing
end

function checkinputs(x::Array{Int}, xmax::Int, xn::Int)
  maximum(x) >= xmax && error("x values must be between 0 and ", string(xmax), ".")
  length(x) != xn && error("size(x)[1] must equal xn.")
  return nothing
end
