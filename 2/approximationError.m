function [ E ] = approximationError( pt , pt_, dt, tend )
%UNTITLED Approximation Error using the euclidean norm and the timstep size
%   this function calculate rhe Approximation Error for two vector values
%   of functions starting on 0 goimngt to tend and using the euclidean norm
%   to claculate the error and multiplys it with the proportion of the
%   timestep to the end time 
    E = sqrt( dt/tend ) * norm(pt_-pt);

end

