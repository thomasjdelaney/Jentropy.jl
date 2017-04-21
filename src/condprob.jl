"""
condprob \\

Calculates the distribution of y conditioned on x \\
Arguments:		dec_x = decimalised version of x \\
							dec_y = decimalised version of y \\
							x_dist_dim = dimension of the probability distribution of x \\
							y_dist_dim = dimension of the probability distribution of y \\
							sampling = the sampling method \\
Returns:			ny, each value of y \\
							pxy, probability of y  given x  \\
"""

function condprob(dec_x::Array{Int,1}, dec_y::Array{Int,1}, x_dist_dim::Int, y_dist_dim::Int, sampling::String)
	ny = zeros(Int, y_dist_dim)
	pxy = zeros(x_dist_dim, y_dist_dim)
	for i in unique(dec_y) # looping through all the potential Y values
		inds = find(i .== dec_y) # the trials where Y = i
		ny[find(i .== unique(dec_y))] = length(inds)
		matching_output = dec_x[inds] # output conditional ensemble
		if length(matching_output) > 0
			pxy[:, i+1] = prob(matching_output, x_dist_dim, sampling)
		else
			println("WARNING: Null output conditional ensemble for output = ", string(i))
		end
	end
	return ny, pxy
end
