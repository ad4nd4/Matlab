clear all; close all;

A = load('babia_gora.dat');
draw(A, 'x', 0, 'Original data');

% ----------------------------------------------

axis = 'x';
angle = 90;

%rotatedA = A * rotateMatrix(axis, angle);
%draw(rotatedA, axis, angle, join(['Rotated around',convertCharsToStrings(axis),'axis by',int2str(angle),'deg']));

rotatedA = A * rotateMatrix('z', 90) * rotateMatrix('x', 90);
draw2(rotatedA, 1, 0, 1, join(['Rotated around',convertCharsToStrings(axis),'axis by',int2str(angle),'deg']));