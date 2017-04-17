# For calculating the support (number of non-zero probabilities) from a Bayesian point of view
# Arguments:  probs = naive probability distribution
#             n_trials = number of trials
# Returns:

function bayessupport(probs::Array{Float64}, n_trials::Int)
  dim = length(probs)
  probs_nonzero = probs[probs .> 0]
  support_naive = length(probs_nonzero)
  support = support_naive
  if support_naive < dim
    support_expected = support_naive - sum((1 - probs_nonzero) .^ n_trials)
    prev_support_delta = dim
    support_delta = abs(support_naive - support_expected)
    xtr = 0.0
    while (support_delta < prev_support_delta) && ((support_naive+xtr)<dim)
      xtr = xtr + 1.0
      support_expected = 0.0
      # occupied bins
      gamma = xtr*(1.0 - (n_trials/(n_trials+support_naive)^(1/n_trials)))
      support_bayes = ((1.0-gamma)/(n_trials+support_naive))*(probs_nonzero*n_trials+1.0)
      suppport_expected = sum(1.0-(1.0-support_bayes)^n_trials)
      # non-occupied bins
      support_bayes = gamma / xtr
      support_expected = support_expected + xtr*(1.0 - (1.0 - support_bayes)^n_trials)
      prev_support_delta = support_delta
      support_delta = abs(support_naive - support_expected)
    end
    support_naive = support_naive + xtr - 1.0
    if support_delta < prev_support_delta
      support_naive += 1.0
    end
  end
return support_naive
end
