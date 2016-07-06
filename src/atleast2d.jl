# For formatting the dimensions of the random variables

function atleast2d(random_variable::Array)
  return 1 == ndims(random_variable) ? reshape(random_variable, size(random_variable)[1], 1) : random_variable
end
