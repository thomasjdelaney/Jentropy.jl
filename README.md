Jentropy.jl
================

A Julia package for entropy and mutual information calculations. Inspired by the Pyentropy package by Robin Ince:
    https://github.com/robince/pyentropy

The pyentropy package package was developed as part of the following research:

    Ince, R. A. A., Petersen, R. S., Swan, D. C. and Panzeri, S. (2009)
    “Python for Information Theoretic Analysis of Neural Data”
    Frontiers in Neuroinformatics 3:4

The Jentropy package allows easy calculation of entropy and mutual information
given experimental data, using 'plugin' probability calculations and 'naive' sampling. The package
is particularly useful for neuronal data e.g. spike trains evoked as a response
to experimental stimuli.

* Allows calculation of entropy of random variables.
* No need to pre-calculate the probability distribution of the data.
* Designed for calculation of response and stimulus entropies.
* Capable of calculation with multivariate, multitrial data.

**Note:** Bias reduction techniques to be added in the future.
