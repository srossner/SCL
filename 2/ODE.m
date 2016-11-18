close all;
clear all;
clc;

p0 = 1;
t0 = 0;
tend = 15;
dtin = 1;

for i = 0:3 
    
    
    dt = dtin / power(2, i);

    t = t0:dt:tend;
    steps = (tend)/dt;

    pt =  p(t);
    dpt = p_(pt);

    pt_e = explicitEuler(@p_, dt, p0, steps);
    pt_h = methodOfHeun(@p_ , dt, p0, steps);
    pt_rk = rungeKuttaMethod(@p_ , dt, p0, steps);


    if( i == 0)
         subplot(4, 1, 1);
    elseif( i == 1) 
         subplot(4, 1, 2);
    elseif( i == 2) 
         subplot(4, 1, 3);
    elseif( i == 3) 
         subplot(4, 1, 4);
    end
    
    plot(t, pt,'color','r'); hold on;
    plot(t, dpt, '--', 'color','r'); 
    plot(t, pt_e,'+','color','b');
    plot(t, pt_h , 'x','color','g');
    plot(t, pt_rk, '.','color','k');

    text( -2 , 11  , 'Euler:');
    text(   0 , 11  , num2str( approximationError(  pt , pt_e, dt, tend )));
    text( -2 ,  9  , 'Heun:'  ); 
    text(   0 ,  9  , num2str( approximationError(  pt , pt_h, dt, tend)));
    text( -2 , 7   , 'RungeK: ');
    text(   0 , 7   , num2str( approximationError(  pt , pt_rk, dt, tend)));
    text( -2 , 5  , strcat('dt: ', num2str(dt)));
    
    text( 5 , 6  , 'RK on Euler:');
    text(   7 , 6  , num2str( approximationError(  pt_rk , pt_e, dt, tend )));
    text( 5 ,  4  , 'RK on Heun:'  ); 
    text(   7 ,  4  , num2str( approximationError(  pt_rk , pt_h, dt, tend)));

    
    axis([-2.5 15 -2 12]) ;

    legend('p(t)', 'dp(t)','explicit Euler', 'method Of Heun' ,'Runge-Kutta Method')



end 



