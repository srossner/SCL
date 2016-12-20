function [north, south, east, west, centre, Vector] = coefficient( Nx, Ny, p , i , PreSol , Tboundary )
hx = 1/(Nx+1);
hy = 1/(Ny+1);
        if(mod(i-1,Nx) == 0)
            east = Tboundary/(hx^2);
        else
            east = (1/(hx^2))*PreSol(i-1);
        end
        centre = (-2/(hx^2)) + (-2/(hy^2));
        if(mod(i,Nx)== 0)
            west = Tboundary/(hx^2);
        else
            west = (1/(hx^2))*PreSol(i+1);
        end
        if(i<=Nx)
            north = Tboundary/(hy^2);
        else
            north = (1/(hy^2))*PreSol(i-Nx);
        end
        if(i>(Ny-1)*Nx)
            south = Tboundary/(hy^2);
        else
            south = (1/(hy^2))*PreSol(i+Nx);
        end
        if(mod(i,Nx)~=0)
            Vector = p(hx*mod(i,Nx),hy*ceil(i/Nx));
        else
            Vector = p(hx*Nx,hy*ceil(i/Nx));
        end
end