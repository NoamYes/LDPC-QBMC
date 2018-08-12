% Author : Miroslav Marinkovic
% E-mail : mmarinkovic78d@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = quantization_func(x, n, Amplitude)

% quantization with clipping 

% n : number of bits used to quantize an input value x
% Amplitude : positive value to define the interval (-Amplitude, Amplitude]
% output y : in the interval (-Amplitude, Amplitude]

% normalization of x
x = x / Amplitude;

% define min and max values
min_value = -1;
max_value = 1 - 1/2^(n-1);

% predefined Matlab function round
x_round = round(x*2^(n-1))/(2^(n-1));

% clip(limit) x_round to the interval [min_value, max_value]
x_round = min(max_value, max(min_value, x_round));

% the most negative value is neglected
y = Amplitude * max(x_round, -max_value);