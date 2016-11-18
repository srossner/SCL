function [ E ] = approximationError( pt , pt_, dt, tend )

    E = sqrt( dt/tend ) * norm(pt_-pt);

end

