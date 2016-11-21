%to close all plots 
close all;
clear all;
clc;

%------------------------------------
% input Parameters in Functions
% p_() is the ordinal differential quation
% p() is the analytical solution
%------------------------------------
% given Values 
% p(0) = 1 
%------------------------------------
% boundry conditions
% p_ = F(y)
% y(0) = y0
%------------------------------------

%from boundry conditions 
p0 = 1;

%start time 
t0 = 0;

% end time to 15 seen from p() that a stabil form is reatched on 
tend = 15;

% starting time step 
dtin = 1;


% this is creatig 4 Grapfs 
for i = 0:3 
    
    
    dt = dtin / power(2, i);

    t = t0:dt:tend;
    steps = (tend)/dt;

    pt =  p(t);
    dpt = p_(pt);

    pt_e = explicitEuler(@p_, dt, p0, steps);
    pt_h = methodOfHeun(@p_ , dt, p0, steps);
    pt_rk = rungeKuttaMethod(@p_ , dt, p0, steps);
    
    figure;
    hold on;
    title(strcat( 'Graph of Ordinal differential Equation with timestep:', num2str(dt)));
    plot(t, pt,'color','r');
    plot(t, dpt, '--', 'color','r'); 
    plot(t, pt_e,'+','color','b');
    plot(t, pt_h , 'x','color','g');
    plot(t, pt_rk, '.','color','k');

    
    % best display on 1920/1080 pixel window sice 
    text( -3.5 , 11  , 'E_{Euler}:');
    text( -1.5 , 11  , num2str( approximationError(  pt , pt_e, dt, tend )));
    text( -3.5 ,  9  , 'E_{Heun}:'  ); 
    text( -1.5 ,  9  , num2str( approximationError(  pt , pt_h, dt, tend)));
    text( -3.5 ,  7   , 'E_{RungeK}: ');
    text( -1.5 ,  7   , num2str( approximationError(  pt , pt_rk, dt, tend)));
    text( -3.5 ,  5  , 'dt: ' );
    text( -1.5 ,  5   , num2str(dt));
    % Aproximated error on Runge Kutta 
    text( -3.5 ,  3  , 'E^~_{Euler}:');
    text( -1.5 ,  3  , num2str( approximationError(  pt_rk , pt_e, dt, tend )));
    text( -3.5 ,  1  , 'E^~_{Heun}:'  ); 
    text( -1.5 ,  1  , num2str( approximationError(  pt_rk , pt_h, dt, tend)));

    
    axis([-4 15 -2 12]) ;

    legend('p(t)', 'dp(t)','explicit Euler', 'method Of Heun' ,'Runge-Kutta Method')


end 



