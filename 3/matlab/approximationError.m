function [ E ] = approximationError( pt , pt_, dt, tend )
%UNTITLED Approximation Error using the euclidean norm and the timstep size
%   this function calculate rhe Approximation error for two vector using
%   the euclidean norm to calculate the error and multiplies it with the 
%   proportion of timestep to the time interval, in our case equal to tend
%   as we are starting on t0 = 0

    if(size(pt_) == size(pt))
        E = sqrt( dt/tend ) * norm(pt_-pt); %norm(X)is same as norm(X,2)
    else
        step = (size(pt)-1)/(size(pt_)-1 );
        pt_e = 1:size(pt_);
        for i = pt_e
            pt_e(i) = pt_(i) - pt(i*step);
        end
        E = sqrt( dt/tend ) * norm(pt_e); %norm(X)is same as norm(X,2)
    end
    
end

