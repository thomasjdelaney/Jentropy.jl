isdefined(Base, :__precompile__) && __precompile__()

module Jentropy

using DataFrames
using StatsBase

export atleast2d,
  bayessupport,
  calcentropy,
  checkinputs,
  condentropy,
  condprob,
  prob,
  requireents,
  requireprobs

include("atleast2d.jl")
include("bayessupport.jl")
include("calcentropy.jl")
include("checkinputs.jl")
include("condentropy.jl")
include("condprob.jl")
include("prob.jl")
include("requireents.jl")
include("requireprobs.jl")
end
