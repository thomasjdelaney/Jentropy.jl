# Jentropy package:
# A package for calculating Shannon's Entropy given to random variables
# Bias error reduction techniques are also implementable

using DataFrames
using StatsBase

include("prob.jl")
include("condProb.jl")
include("condEntropy.jl")
include("atleast2d.jl")
include("checkinputs.jl")

root = string(homedir(), "/Jentropy")
data_dir = "$root/data"
exp_frame = readtable("$data_dir/P38_2_psth.csv")
res_frame = readtable("$data_dir/P38_2_pyentropy.csv")
resp_frame = readtable("$data_dir/P38_2_resp.csv")
response = convert(Array{Int}, resp_frame[:raw_count]) # response and stimulus must be integer arrays
stimulus = convert(Array{Int}, resp_frame[:adj_stimulus]) # response and stimulus must be integer arrays
method = "plugin" # will need more eventually
sampling = "naive"
calc = ["HX", "HXY"]

# initialising type constants
x = response
y = stimulus
ydims = [length(Y), 1 + maximum(Y)]
xdims = [length(X), 1 + maximum(X)]
X_n = X_dimensions[1]
X_m = X_dimensions[2]
Y_n = Y_dimensions[1]
Y_m = Y_dimensions[2]
X_dimension = X_m ^ X_n
Y_dimension = Y_m ^ Y_n
N = X_m
Ny = zeros(Int, Y_dimension)

# allocating memory for requested calculations
PY = zeros(Y_dimension) # will hold the Y probabilities eventually
PX = zeros(X_dimension) # will hold the X probabilities eventually
PXY = zeros(X_dimension, Y_dimension)

d_X = X # I think this is supposed to be a 1D version of X
d_Y = Y # ''

PX = prob(d_X, X_m)
PY = prob(d_Y, Y_m)
Ny, PXY = condprob(d_X, d_Y, X_dimension, Y_dimension)

HX = entropy(PX, 2)
HY = entropy(PY, 2)
HXY = condEntropy(PY, PXY, 2)
I = HX - HXY

# need to start writing the actual function here.
# there's a function in the 'StatsBase' package named entropy
# I need to read about this
