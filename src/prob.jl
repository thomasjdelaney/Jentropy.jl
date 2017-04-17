# for the prob function specifically
# Arguments:	x = array, the random variable
#							xmax = the maximum value of x
#							sampling = the sampling method
# Returns:		probs, The probability distribution of x

function prob(x::Array{Int}, xmax::Int, sampling::String)
	edges=(0:xmax) - 0.5
	bin_counts = zeros(Int, xmax)
	for trial in 1:size(x)[2]
		bin_counts += fit(Histogram, x[:,trial], edges).weights
	end
	if sampling == "naive" # TODO add more sampling methods
		probs = bin_counts/length(x)
	end
	return probs
end
