# Jentropy package:
# A package for calculating Shannon's Entropy given to random variables
# Bias error reduction techniques are also implementable

using DataFrames

root = string(homedir(), "/Jentropy")
data_dir = "$root/data"
exp_frame = readtable("$data_dir/P38_2_psth.csv")
response = convert(Array{Int}, exp_frame[:spike_count])
stimulus = convert(Array{Int}, exp_frame[:adj_stimulus])
method = "plugin" # will need more eventually
sampling = "naive"
calc = ["HX", "HXY"]

# response and stimulus must be integer arrays
X = response
Y = stimulus
Y_dimension = 1 + maximum(Y)
X_dimension = 1 + maximum(X)
PY = zeros(Y_dimension) # will hold the Y probabilities eventually
PX = zeros(X_dimension) # will hold the X probabilities eventually
PXY = zeros(X_dimension, Y_dimension)

# need to start writing the actual function here.
