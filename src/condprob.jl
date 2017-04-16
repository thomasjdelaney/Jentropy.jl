# Calculates the distribution of y conditioned on x
# Arguments:	x = random variable
#							y = random variable
#							xmax = maximum value of x
# 						ymax = maximum value of y
#							sampling = the sampling method
# Returns:		ny, each value of y
#							pxy, probability of y given x

function condprob(x::Array{Int}, y::Array{Int}, xmax::Int, ymax::Int, sampling::String)
	ny = zeros(Int, ymax)
	pxy = zeros(xmax, ymax)
	for i in unique(y) # looping through all the potential Y values
		inds = find(i .== y) # the trials where Y = i
		ny[find(i .== unique(y))] = length(inds)
		matching_output = x[inds] # output conditional ensemble
		if length(matching_output) > 0
			pxy[:, i+1] = prob(matching_output, xmax, sampling)
		else
			println("WARNING: Null output conditional ensemble for output = ", string(i))
		end
	end
	return ny, pxy
end
