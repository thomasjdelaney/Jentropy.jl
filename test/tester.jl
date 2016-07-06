# Jentropy package:
# A package for calculating Shannon's Entropy given to random variables
# Bias error reduction techniques are also implementable

using DataFrames
using StatsBase

root = string(homedir(), "/Jentropy")

include("prob.jl")
include("condProb.jl")
include("condEntropy.jl")
include("atleast2d.jl")
include("checkinputs.jl")
include("requireprobs.jl")
include("requireents.jl")
include("calcentropy.jl")

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

x = response
y = stimulus
ydims = [length(y), 1 + maximum(y)]
xdims = [length(x), 1 + maximum(x)]

ent_dict = calcentropy(x, y, xdims, ydims, calc, method, sampling)
I = ent_dict["HX"] - ent_dict["HXY"]
