# for the prob function specifically

function prob(x::Array{Int}, xmax::Int, sampling::ASCIIString)
  # x = array, the random variable
	bin_counts = hist(x, xmax)[2] # bin the random variable and return the count for each bin.
	if length(bin_counts) < xmax
		bin_counts = vcat(bin_counts, zeros(eltype(bin_counts), xmax - length(bin_counts)))
	end
	if sampling == "naive"
		probs = bin_counts/length(x)
	end
	return probs
end
