# for the condProb function

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
