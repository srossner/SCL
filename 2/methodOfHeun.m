function [ pt ] = methodOfHeun( p_ , dt, p0, steps)

    pn = p0;
    pt = p0;
    
    for s = 1:steps
        pn1 = pn + dt * p_(  explicitEulerStep(p_, dt/2, pn) );
        pt = [pt pn1];
        pn = pn1;
    end

end


