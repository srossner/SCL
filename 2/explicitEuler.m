function [ pt ] = explicitEuler( p_, dt, p0, steps)

    pn = p0;
    pt = p0;
    
    for s = 1:steps
        pn1 =  explicitEulerStep( p_, dt, pn);
        pt = [pt pn1];
        pn = pn1;
    end

end

