# For calculating the support (number of non-zero probabilities) from a Bayesian point of view

# P = naive probability distribution
# N = number of trials
function bayessupport(P::Array{Float64}, N::Int)
  dim = length(P)
  P_nonzero = P[P .> 0]
  support_naive = length(P_nonzero)
  support = support_naive
  if support_naive < dim
    support_expected = support_naive - sum((1 - P_nonzero) .^ N)
    prev_support_delta = dim
    support_delta = abs(support_naive - support_expected)
    xtr = 0.0
    
