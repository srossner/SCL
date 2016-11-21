function [ pn1 ] = explicitEulerStep( p_, dt, pn)
%UNTITLED Calculation the next step of an ordinary differential equatio with
%explicit Euler
    pn1 = pn + dt * p_(pn);
end

