
<a id='calcentropy.jl-Documentation-1'></a>

# calcentropy.jl Documentation

<a id='Jentropy.calcentropy' href='#Jentropy.calcentropy'>#</a>
**`Jentropy.calcentropy`** &mdash; *Function*.



calcentropy

Calculates the requested entropies using the x and y variables given. Arguments:  x = random variable, usually input             y = random variable, usually output/classification             xdims = [length of trial vector, least upper bound of x (the number of possible values)]             ydims = [length of trial vector, least upper bound of y (the number of possible values)]             calc = The entropies to calculate ex: ["HX", "HXY"]             method = sampling bias correction method ex: "pt"             sampling = method for sampling ex: "naive" Returns:    dictionary, entropies listed in calc => the entropy values

