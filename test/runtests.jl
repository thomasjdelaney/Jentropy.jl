# Jentropy package:
# A package for calculating Shannon's Entropy given to random variables
# Bias error reduction techniques are also implementable

push!(LOAD_PATH, homedir() * "/Jentropy.jl/src")
using DataFrames
using Jentropy
using Base.Test

# 1-d column of zeros, should have 0 bits of information
@test calcentropy(zeros(Int, 100), [100, 10], ["HX"], "plugin", "naive")["HX"] ≈ 0

# 1-d binary column, 50 1s and 50 0s, should have 1 bit of information
@test calcentropy(transpose([zeros(Int, 50); ones(Int, 50)]), [1, 2], ["HX"], "plugin", "naive")["HX"] ≈ 1

# 1-d ternary column, 50 0s, 50 1s, and 50 2s, should have 2 bits of information
@test calcentropy(transpose([zeros(Int, 50); ones(Int, 50); 2*ones(Int, 50)]), [1, 3], ["HX"], "plugin", "naive")["HX"] ≈ log(2, 3)

# 1-d column 4 possible entries, 50 0s, 50 1s, 50 2s, 50 3s, should have 2 bits of information
@test calcentropy(transpose([zeros(Int, 50); ones(Int, 50); 2*ones(Int, 50); 3*ones(Int, 50)]), [1, 4], ["HX"], "plugin", "naive")["HX"] ≈ 2

# loading in data and results calculated by pyentropy package
data_dir = string(homedir(), "/Jentropy.jl/data");
res_frame = readtable("$data_dir/P38_2_pyentropy.csv");
resp_frame = readtable("$data_dir/P38_2_resp.csv");
response = convert(Array{Int}, resp_frame[:raw_count]); # response and stimulus must be integer arrays
stimulus = convert(Array{Int}, resp_frame[:adj_stimulus]); # response and stimulus must be integer arrays

# mouse retina data, retina P38 cell 2 is an 'on' cell, should have mutual information of 1 bit.
x = transpose(response);
y = transpose(stimulus);
xdims = [1, 1 + maximum(x)];
ydims = [1, 1 + maximum(y)];
retina_ent = calcentropy(x, y, xdims, ydims, ["HX", "HXY"], "plugin", "naive");
@test (retina_ent["HX"] - retina_ent["HXY"]) ≈ 1

# Shuffle the response and stimulus and add it to the previous stimulus to test multi-trial entropy calculation
shuffled_inds = shuffle(1:length(response));
x = transpose([response response[shuffled_inds]]);
y = transpose([stimulus stimulus[shuffled_inds]]);
xdims = [size(x)[1], 1 + maximum(x)];
ydims = [size(y)[1], 1 + maximum(y)];
calc = ["HX", "HXY"]; method = "plugin"; sampling = "naive";
retina_ent = calcentropy(x, y, xdims, ydims, calc, method, sampling);

# using the iris RDataset
using RDatasets
iris = dataset("datasets", "iris");

# multivariate x
x = transpose(convert(Array{Int}, 10 * Array(iris[[:SepalLength, :SepalWidth, :PetalLength, :PetalWidth]])));
xdims = [size(x)[1], 1 + maximum(x)];
calc = ["HX"]; method="plugin"; sampling="naive";
calcentropy(x, xdims, calc, method, sampling);

# multivariate x with a second variable
x = transpose(convert(Array{Int}, 10 * Array(iris[[:SepalLength, :SepalWidth, :PetalLength, :PetalWidth]])));
y = transpose([findn(unique(iris[:Species]) .== s)[1] for s in iris[:Species]]);
xdims = [size(x)[1], 1 + maximum(x)];
ydims = [size(y)[1], 1 + maximum(y)];
calc = ["HX", "HXY"]; method = "plugin"; sampling = "naive";
r = calcentropy(x, y, xdims, ydims, calc, method, sampling);
display(r) # should agree with whatever Python (& Matlab) calculate
