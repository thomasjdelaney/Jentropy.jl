# For formatting the dimensions of the random variables to at least 2 dimensions
# Arguments:  random_variable
# Returns: A 2-d version of the variable

function atleast2d(random_variable::Array)
  is_one_d = 1 == ndims(random_variable)
  return is_one_d ? reshape(random_variable, size(random_variable)[1], 1) : random_variable
end
