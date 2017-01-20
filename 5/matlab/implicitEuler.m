function Temp = implicitEuler( InitialCondition , Tstart , Tend , TimeStep , Nx , Ny , accuracy )
hx = 1/(Nx+1);
hy = 1/(Ny+1);
Temp = InitialCondition;
north = 1/(hy*hy);
south = 1/(hy*hy);
east = 1/(hx*hx);
west = 1/(hx*hx);
idt = 1/TimeStep;
centre = ( idt + (2*north) + (2*east));
inverseCentre = 1/centre;
N = ( Tend - Tstart )*idt;
for i = 1:abs(N)

    PreTemp = Temp ;
    iteration = 0;
    R = 1;
    
    while ( R > accuracy )
    
        iteration = iteration + 1 ;  
        Temp(2:Nx+1,2:Ny+1) = inverseCentre*((north*Temp(1:Nx,2:Ny+1))....
                            + (south*Temp(3:Nx+2,2:Ny+1))....
                            + (east*Temp(2:Nx+1,1:Ny))....
                            + (west*Temp(2:Nx+1,3:Ny+2))....
                            + (idt*PreTemp(2:Nx+1,2:Ny+1)));
                     
        R = sqrt(abs((sum(sum((north*Temp(1:Nx,2:Ny+1))....
          + (south*Temp(3:Nx+2,2:Ny+1))....
          + (east*Temp(2:Nx+1,1:Ny)) ....
          + (west*Temp(2:Nx+1,3:Ny+2))....
          + (idt*PreTemp(2:Nx+1,2:Ny+1))....
          - (centre * Temp(2:Nx+1,2:Ny+1))))))/(Nx*Ny));
                     
    end

end

end