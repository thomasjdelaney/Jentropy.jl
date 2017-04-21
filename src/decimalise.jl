"""
decimalise \\

For taking multivariate random variables and returning them as a single variable \\
in the base of the maximum value. \\
Arguments:  x, the random variable \\
            xn, number of variables in x \\
            xmax, the maximum number of possible values across the dimensions in x \\
Returns:    dec_x, Array{Int}, decimalised x \\
"""

function decimalise(x::Array{Int}, xn::Int, xmax::Int)
  if size(x)[1] != xn || maximum(x) > xmax
    error("Input dimension error!")
  end
  power_vector = xmax .^ (xn-1:-1:0)
  dec_x = size(x)[1] == 1 ? reshape(x, length(x)) : transpose(x) * power_vector
  return dec_x
end
