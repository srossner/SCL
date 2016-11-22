function [ E ] = approximationError( pt , pt_, dt, tend )
%UNTITLED Approximation Error using the euclidean norm and the timstep size
%   this function calculate rhe Approximation error for two vector using
%   the euclidean norm to claculate the error and multiplys it with the 
%   proportion of timestep to the time interval in our case equal to tend
%   as we are starting on t0 = 0
    E = sqrt( dt/tend ) * norm(pt_-pt);

end

