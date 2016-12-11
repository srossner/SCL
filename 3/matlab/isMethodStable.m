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
    
    if(isnan(Data))
        MethodStable = false;
    end
    
    switch ( MethodStable )
        case true
            Answer = 'stable';
        case false
            Answer = 'unstable';
        otherwise
            Answer = 'Error during the processing data';
    end
end