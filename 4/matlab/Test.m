clc;
clear;

A = [ 1 4 3 ; 4 5 6 ; 7 8 9 ];
b = [ 10 ; 32 ; 50];

x = A\b

x0 = [ 0; 0; 0];

GaussSeidel(A, x0, b, 5)
