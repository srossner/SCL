function Temp = explicitEuler( PreTemp , Tstart , Tend , TimeStep , Nx , Ny )
hx = 1/(Nx+1);
hy = 1/(Ny+1);
Temp = PreTemp;
north = 1/(hy*hy);
south = 1/(hy*hy);
east = 1/(hx*hx);
west = 1/(hx*hx);
centre = ((1/TimeStep) - (2/(hx*hx)) - (2/(hy*hy)));
N = ( Tend - Tstart )/TimeStep;
for i = 1:abs(N)
    Temp(2:Nx+1,2:Ny+1) = TimeStep*((north*PreTemp(1:Nx,2:Ny+1))....
                         + (south*PreTemp(3:Nx+2,2:Ny+1))....
                         + (east*PreTemp(2:Nx+1,1:Ny))....
                         + (west*PreTemp(2:Nx+1,3:Ny+2))....
                         + (centre*PreTemp(2:Nx+1,2:Ny+1)));
    PreTemp = Temp;
end

end