# for the prob function specifically

function prob(d_X::Array{Int}, X_m::Int, method::ASCIIString)
  # d_X = array, the random variable
	bin_counts = hist(d_X, X_m)[2] # bin the random variable and return the count for each bin.
	if length(bin_counts) < X_m
		bin_counts = vcat(bin_counts, zeros(eltype(bin_counts), X_m - length(bin_counts)))
	end
	if method == "naive"
		probs = bin_counts/length(d_X)
	end
	return probs
end
