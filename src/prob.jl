# for the prob function specifically
# Arguments:	x = array, the random variable
#							xmax = the maximum value of x
#							sampling = the sampling method
# Returns:		probs, The probability distribution of x
function prob(x::Array{Int}, xmax::Int, sampling::String)
	bin_counts = fit(Histogram, x, nbins=xmax).weights # bin the random variable and return the count for each bin.
	if length(bin_counts) < xmax
		bin_counts = vcat(bin_counts, zeros(eltype(bin_counts), xmax - length(bin_counts)))
	end
	if sampling == "naive" # TODO add more sampling methods
		probs = bin_counts/length(x)
	end
	return probs
end
