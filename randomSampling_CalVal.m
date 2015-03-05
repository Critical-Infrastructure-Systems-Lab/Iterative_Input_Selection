function [ X_cal, X_val ] = randomSampling_CalVal( X, lv )

% This function randomply split the dataset in two subsets for calibration
% and validation.
%
% Inputs: 
% X      = dataset of observations
% lv     = number of observations for validation
%
% Output: 
% X_cal  = subset for calibration
% X_val  = subset for validation
%
% Copyright 2014 Matteo Giuliani
% Research Fellow, Politecnico di Milano
% matteo.giuliani@polimi.it
% http://giuliani.faculty.polimi.it
%
%
% Please refer to README.txt for further information.
%
%
% This file is part of MATLAB_IterativeInputSelection.
% 
%     MATLAB_IterativeInputSelection is free software: you can redistribute 
%     it and/or modify it under the terms of the GNU General Public License 
%     as published by the Free Software Foundation, either version 3 of the 
%     License, or (at your option) any later version.     
% 
%     This code is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MATLAB_IterativeInputSelection.  
%     If not, see <http://www.gnu.org/licenses/>.

% Random permutation of the indices
[ r, c ] = size( X ) ;
i_tmp = randperm( r );

% Split the dataset X into calibration (X_cal) and validation (X_val)
i_val = i_tmp(1:lv) ;
i_cal = i_tmp(lv+1:end);

X_val = X( i_val, : ) ;
X_cal = X( i_cal, : ) ;

end



