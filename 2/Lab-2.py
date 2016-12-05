# -*- coding: utf-8 -*-
"""

Hello world
"""
#!/usr/bin/env python
import numpy as np
import matplotlib.pyplot as plt
import math

def main():
    FirstGraph = plt.figure()
    
    # Get initial conditions    
    StartTime = 0
    EndTime = 10
    P_InitialValue = 1

    for i in range( 1, 5 ):
        # Get time step and number of iterations
        TemeStep = float( 2 ) / pow( 2, i )

        StepsNumber = 1 + EndTime / TemeStep

        
        # Get real function values
        Time = np.linspace( StartTime, EndTime, int( StepsNumber ) )
        P = getFunction( Time )
        
        # Get numerical approximation
        EulerP = EulerMethod( P_InitialValue, TemeStep, StepsNumber )
        HeunP = HeunMethod( P_InitialValue, TemeStep, StepsNumber )
        RungeKuttaP = RungeKuttaMethod( P_InitialValue, TemeStep, StepsNumber )
       
        # Get real errors of all methods
        EulerRealError = getRealError( P, EulerP, Time, TemeStep )
        HeunRealError = getRealError( P, HeunP, Time, TemeStep )
        RungeKuttRealError = getRealError( P, RungeKuttaP, Time, TemeStep )
        
        # Get relative errors of the first two methods relative to 
        # Runge Kutta method
        EulerRelativeError = getRealError( RungeKuttaP, EulerP, Time, TemeStep )
        HeunRelativeError = getRealError( RungeKuttaP, HeunP, Time, TemeStep )
        
        #Plot the result
        FirstGraph.add_subplot( 2,2, i )
        
        # Adjust axis
        plt.xlabel('Time');
        plt.ylabel('Function Value');
        
        # Print curves
        plt.plot( Time, P, "*" )
        plt.plot( Time, EulerP, "y-", linewidth=2.0 )
        plt.plot( Time, HeunP, "--" )
        plt.plot( Time, RungeKuttaP, "b" )
        
        # Print corresponding information
        TopX = 7
        TopY = 12
        plt.axis( [ 0, TopX, 0, TopY ] )
        plt.text( 0.1 , TopY - 1, "EulerRealError: " \
                                        + str( EulerRealError ) );
        plt.text( 0.1 , TopY - 1.75, "HeunRealError: " \
                                         + str( HeunRealError ) );
        plt.text( 0.1 , TopY - 2.5, "RungeKuttRealError: " \
                                    + str( RungeKuttRealError ) );
        plt.text( 0.1 , TopY - 3.25, "TimeStep: " + str( TemeStep ) );        
        
        plt.text( TopX - 5 , 2.25, "EulerRelativeError: " \
                                                + str( EulerRelativeError ) );
        plt.text( TopX - 5 , 1.5, "HeunRelativeError: " \
                                                + str( HeunRelativeError ) );

    plt.show()
    

def getFunction( Time ):
    Size = len( Time )
    P = range( 0, Size )
    for i in range( 0, Size ):
        P[ i ] = 10 / ( 1 + 9 * np.exp( -Time[ i ] ) )
    return P


def Derivative( FunctionValue ):
    DerivativeValue = ( 1 - FunctionValue / 10 ) * FunctionValue
    return DerivativeValue


def EulerMethod( P_InitialValue, TemeStep, StepsNumber ):
    P = range( 0, int( StepsNumber ) )
    P[ 0 ] = P_InitialValue
    
    for i in range( 1, int( StepsNumber ) ):
        P[ i ] = P[ i - 1 ] + TemeStep * Derivative( P[ i - 1 ] )
    return P


def HeunMethod( P_InitialValue, TemeStep, StepsNumber ):
    P = range( 0, int( StepsNumber ) )
    P[ 0 ] = P_InitialValue
    k1 = 0.0
    k2 = 0.0
    
    for i in range( 1, int( StepsNumber ) ):
        k1 = TemeStep * Derivative( P[ i - 1 ] )
        k2 = TemeStep * Derivative( P[ i - 1 ] + 0.5 * k1 )
        P[ i ] = P[ i - 1 ] + k2
    return P


def RungeKuttaMethod( P_InitialValue, TemeStep, StepsNumber ):
    P = range( 0, int( StepsNumber ) )
    P[ 0 ] = P_InitialValue
    k1 = 0.0
    k2 = 0.0
    k3 = 0.0
    k4 = 0.0
    
    for i in range( 1, int( StepsNumber ) ):
        k1 = TemeStep * Derivative( P[ i - 1 ] )
        k2 = TemeStep * Derivative( P[ i - 1 ] + 0.5 * k1 )
        k3 = TemeStep * Derivative( P[ i - 1 ] + 0.5 * k2 )
        k4 = TemeStep * Derivative( P[ i - 1 ] + k3 )
        P[ i ] = P[ i - 1 ] + ( k1 + 2 * k2 + 2 * k3 + k4 ) / 6 
    return P
 
   
def getRealError( PReal, PEstimated, Time, TemeStep ):
    Size = len( Time )
    EndTime = Time[ Size - 1 ]
    Error = 0.0;
    for i in range( 1, int( Size ) ):
        Error += ( PEstimated[ i ] - PReal[ i ] )**2
    Error *= ( TemeStep / EndTime ) 
    Error = math.sqrt( Error )
    return Error
#    Error = 

main()
