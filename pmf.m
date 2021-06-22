function [vals, freqs] = pmf(X)
%#PMF Return the probability mass function for a vector/matrix.
%#
%#INPUTS:
%#   X       Input matrix
%#
%#OUTPUTS:
%#   VALS    Vector of unique values
%#   FREQS   Vector of frequencies of occurence of each value.
%#

    [vals,junk,idx] = unique(X);

    vals   = vals(:);
    frequs = NaN(length(vals),1);

    for i = 1:length(vals)
        freqs(i) = mean(idx == i);
    end

    %# If 0 or 1 output is requested, put the values and counts in two columns
    %# of a matrix.
    if nargout < 2
        vals = [vals freqs];
    end

end