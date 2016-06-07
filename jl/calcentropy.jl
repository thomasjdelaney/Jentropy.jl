# Jentropy package:
# A package for calculating Shannon's Entropy given to random variables
# Bias error reduction techniques are also implementable

using DataFrames
using StatsBase

root = string(homedir(), "/Jentropy")
data_dir = "$root/data"
exp_frame = readtable("$data_dir/P38_2_psth.csv")
res_frame = readtable("$data_dir/P38_2_pyentropy.csv")
resp_frame = readtable("$data_dir/P38_2_resp.csv")
response = convert(Array{Int}, exp_frame[:spike_count]) # response and stimulus must be integer arrays
stimulus = convert(Array{Int}, exp_frame[:adj_stimulus]) # response and stimulus must be integer arrays
method = "plugin" # will need more eventually
sampling = "naive"
calc = ["HX", "HXY"]

# initialising type constants
X = response
Y = stimulus
Y_dimensions = [ndims(Y), 1 + maximum(Y)]
X_dimensions = [ndims(X), 1 + maximum(X)]
X_n = X_dimensions[1]
X_m = X_dimensions[2]
Y_n = Y_dimensions[1]
Y_m = Y_dimensions[2]
X_dimension = X_m ^ X_n
Y_dimension = Y_m ^ Y_n
N = X_m
Ny = zeros(Int, Y_dimension)

# allocating memoey for requested calculations
PY = zeros(Y_dimension) # will hold the Y probabilities eventually
PX = zeros(X_dimension) # will hold the X probabilities eventually
PXY = zeros(X_dimension, Y_dimension)

d_X = X # I think this is supposed to be a 1D version of X
d_Y = Y # ''

function prob(d_X, X_m, method="naive")
	bin_counts = hist(d_X, X_m)[2] # bin the random variable and return the count for each bin.
	if length(bin_counts) < X_m
		bin_counts = vcat(bin_counts, zeros(eltype(bin_counts), X_m - length(bin_counts)))
	end
	if method == "naive"
		probs = bin_counts/length(d_X)
	end
	return probs
end

function condProb(d_X, d_Y, X_dimension, Y_dimension)
	Ny = zeros(Int, Y_dimension)
	PXY = zeros(X_dimension, Y_dimension)
	for i in unique(d_Y) # looping through all the potential Y values
		inds = find(i .== d_Y) # the trials where Y = i
		Ny[find(i .== unique(d_Y))] = length(inds)
		matching_output = d_X[inds] # output conditional ensemble
		if length(matching_output) > 0
			PXY[:, i+1] = prob(matching_output, X_dimension)
		else
			println("WARNING: Null output conditional ensemble for output = ", string(i))
		end
	end
	return Ny, PXY
end

PX = prob(d_X, X_m)
PY = prob(d_Y, Y_m)
Ny, PXY = condProb(d_X, d_Y, X_dimension, Y_dimension)

function jentropy(prob_dist::Array{Float64, 1})
	masked_prob_dist = filter(p -> p > eps(Float64), prob_dist)
	return -sum(masked_prob_dist .* log2(masked_prob_dist))
end

function jentropy(prob_dist::Array{Float64, 2})
  ents = zeros(size(prob_dist, 2))
	for i=1:size(prob_dist, 2)
		masked_prob_dist = filter(p -> p > eps(Float64), prob_dist[i, :])
		ents[i] = -sum(masked_prob_dist .* log2(masked_prob_dist))
  end
  return ents
end

HX = jentropy(PX)
HY = jentropy(PY)


# need to start writing the actual function here.
# there's a function in the 'StatsBase' package named entropy
# I need to read about this
