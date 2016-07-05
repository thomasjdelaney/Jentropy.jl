# for the condEntropy function specifically

using StatsBase

function condEntropy(marg_dist::Array{Float64, 2}, cond_dists::Array{Float64}, base)
	# dists = Array{Float64}, each vector should be a conditional distribution
	length(marg_dist) == size(cond_dists)[2] || error("Number of marginal and conditional distributions does not match!")
	ents = [entropy(cond_dists[:, i], base) for i = 1:size(cond_dists)[2]]
	return sum(marg_dist .* ents)
end
