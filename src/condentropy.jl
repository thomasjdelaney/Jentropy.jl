# for the condEntropy function specifically, calculating conditional entropy
# Arguments:	marg_dist, marginal distributions
#							cond_dists, conditional distributions
#							base, the base for entropy calculations
# Returns:		Float64, the conditional entropy

using StatsBase

function condentropy(marg_dist::Array{Float64,1}, cond_dists::Array{Float64}; base::Int=2)
	length(marg_dist) == size(cond_dists)[2] || error("Number of marginal and conditional distributions does not match!")
	ents = [entropy(cond_dists[:, i], base) for i = 1:size(cond_dists)[2]]
	return sum(marg_dist .* ents)
end
