function [ pt ] = rungeKuttaMethod( p_ , dt, p0, steps)

    pn = p0;
    pt = p0;
    
    for s = 1:steps
       
        k1 = dt * p_(  pn  );
        
        k2 = dt * p_(  pn + ( 0.5* k1 ) ) ;
        
        k3 = dt * p_(  pn + ( 0.5* k2 ) ) ;
        
        k4 = dt * p_(  pn + k3 );

        pn1 = pn + ( 1/6 * ( k1 + 2*k2 + 2*k3 + k4) );
        
        pt = [pt pn1];
        pn = pn1;
    end

end


