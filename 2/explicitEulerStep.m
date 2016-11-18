function [ pn1 ] = explicitEulerStep( p_, dt, pn)
    pn1 = pn + dt * p_(pn);
end

