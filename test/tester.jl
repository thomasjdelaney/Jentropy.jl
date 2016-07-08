# Jentropy package:
# A package for calculating Shannon's Entropy given to random variables
# Bias error reduction techniques are also implementable

using DataFrames
using Jentropy

root = string(homedir(), "/Jentropy.jl")

# loading in data and results calculated by pyentropy package
data_dir = "$root/data"
res_frame = readtable("$data_dir/P38_2_pyentropy.csv")
resp_frame = readtable("$data_dir/P38_2_resp.csv")
response = convert(Array{Int}, resp_frame[:raw_count]) # response and stimulus must be integer arrays
stimulus = convert(Array{Int}, resp_frame[:adj_stimulus]) # response and stimulus must be integer arrays

method = "plugin" # will need more eventually
sampling = "naive"

# 1-d columns of zeros, should have 0bits of information
calc = ["HX"]
x = zeros(Int, 100)
xdims = [100, 10]
zero_ent = calcentropy(x, xdims, calc, method, sampling)

# mouse retina data
x = response
y = stimulus
ydims = [length(y), 1 + maximum(y)]
xdims = [length(x), 1 + maximum(x)]
calc = ["HX", "HXY"]
retina_ent = calcentropy(x, y, xdims, ydims, calc, method, sampling)
I = retina_ent["HX"] - retina_ent["HXY"]
