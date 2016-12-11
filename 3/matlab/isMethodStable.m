function Answer =  isMethodStable( Data, InitialValue, equilibriumPoint )
    MethodStable = true;
    Distance = abs( InitialValue - equilibriumPoint );
    MaxSolutionDeviation = equilibriumPoint + Distance;
    MinSolutionDeviation = equilibriumPoint - Distance;
    
    DataSize = length( Data );
    for i=1:DataSize
        if ( ( Data( 1, i ) > MaxSolutionDeviation ) ...
          || ( Data( 1, i ) < MinSolutionDeviation ) )
            MethodStable = false;
            break;
        end
    end
    
    switch ( MethodStable )
        case true
            Answer = 'STABLE';
        case false
            Answer = 'UNSTABLE';
        otherwise
            Answer = 'Error during the processing data';
    end
end