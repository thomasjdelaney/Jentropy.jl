"""
prob \\

for the prob function specifically \\
Arguments:	dec_x = array, the decimalised random variable \\
						x_dist_dim = dimension of the probability distribution of x \\
						sampling = the sampling method \\
Returns:		probs, The probability distribution of x \\
"""

function prob(dec_x::Array{Int, 1}, x_dist_dim::Int, sampling::String)
	edges=(0:x_dist_dim) - 0.5
	bin_counts = fit(Histogram, dec_x, edges).weights
	if sampling == "naive" # TODO add more sampling methods
		probs = bin_counts/length(dec_x)
	end
	return probs
end
