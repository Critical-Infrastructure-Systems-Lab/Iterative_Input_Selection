function [X, R2] = visualize_inputSel( iis_res, Nvar, Nrun, max_iter, map ) 

% [X, R2] = visualize_inputSel( iis_res, Nvar, Nrun, max_iter, map ) 
%
% This function plots the results of multiple runs of the IIS algorithm to
% analyze the input ranking and the variability of the final MISO models'
% performance over different runs.
%
% input:
%   iis_res     = cell array containing the output of the
%               iterative_input_selection funtion
%   Nvar        = number of candidate input variables (in theory this is
%               equal to the number of columns of the dataset, in practice
%               it can be reduced to max_iter) 
%   Nrun        = number of IIS runs
%   max_iter    = max number of iterations in each run of IIS 
%   map         = colormap (default = hot)
%
% output:
%   X           = matrix containing the indices of the selected input for
%               each run (on the columns)
%   R2          = corresponding model performance
%
%
% Copyright 2014 Stefano Galelli and Matteo Giuliani
% Assistant Professor, Singapore University of Technology and Design
% stefano_galelli@sutd.edu.sg
% http://people.sutd.edu.sg/~stefano_galelli/index.html
% Research Fellow, Politecnico di Milano
% matteo.giuliani@polimi.it
% http://home.deib.polimi.it/giuliani/
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
% 



% check number of inputs
if(nargin<4) 
  error(  'too few arguments'  ) ;
  error(  'usage: visualize_inputSel( iis_res, Nvar, Nrun, max_iter, map ) '  );
end

if(nargin<5)
    mymap = 'Hot';
else
    mymap = map;
end

% extract results
sel_variables = nan(Nvar,Nrun);
R2    = nan(Nvar,Nrun);
for i = 1:Nrun
    for j = 1:max_iter-1
        eval(['sel_variables(j,i) = iis_res{',num2str(i),'}.iter_',num2str(j),'.best_SISO(1);'])
        eval(['R2(j,i) = iis_res{',num2str(i),'}.iter_',num2str(j),'.MISO.cross_validation.performance.Rt2_val_pred_mean;']);
        if( j>1) && (R2(j,i) < R2(j-1,i)) % check overfitting
            sel_variables(j,i) = nan;
            R2(j,i) = nan;
        end
    end
end

% selected variables and model performance over multiple runs
X = sel_variables;
X(isnan(X)) = Nvar+1;

figure; subplot(2,1,1); imagesc(X); colormap(mymap)
ylabel('input ranking');
subplot(2,1,2); plot(max(R2), 'k', 'LineWidth', 2); grid on;
axis([1 Nrun fix(min(max(R2))*100)/100 fix(max(max(R2))*100+1)/100]);
ylabel('model performance R2');
xlabel('IIS run');


% This code has been written by Matteo Giuliani.

end
