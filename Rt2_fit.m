function    R = Rt2_fit(yo,ys)

% This function calculates the value of the coefficient of determinarion R2
%
% Input:
% yo = observed data
% ys = simulated (or predicted) data
%
% Output
% R = coefficient of determination


if(nargin ~= 2)
  disp(  'error: wrong number of inputs'  )
  return;
end;


R = 1-[(cov(yo-ys)/cov(yo))];