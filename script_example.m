% This script shows how to run the MATLAB_IterativeInputSelection_with_Rtree-c 
% toolbox for a test example. The algorithm ranks and selects the most relevant 
% variables with respect to an output of interest. 
% 
% For the script to work, the Regression tree package source code must have 
% been compiled, and the resulting mex files copied to the main directory. 
% This directory must then be added to the MATLAB PATH. Refer to INSTALL.txt 
% for further information on the steps to follow. 

%% Set workspace
clear
clc

%% Load and prepare data

% load data
load -ascii Friedman_dataset.txt

% rename data
data = Friedman_dataset;
clear Friedman_dataset

% Set the parameters for the Extra-Trees
M    = 500; % number of extra trees in the forest
nmin = 5; % number of points per leaf

% Set the parameters for IIS
ns       = 5;  % number of folds for the cross-validation
p        = 3;  % number of SISO models evaluated at each iteration
epsilon  = 0;  % tolerance
max_iter = 6;  % maximum number of iterations
verbose  = 1;  % 0 for silent run / 1 for verbose mode 



% Launch the IIS
result_iis = perform_IIS(data,M,nmin,ns,p,epsilon,...
    max_iter,flag,verbose)

% Report exit condition
disp(result_iis.exit_condition);

% Selected variables (by iteration)
if strcmp(result_iis.exit_condition,...
        'An input variable was selected twice') == 1
    nVariables = max_iter - 1;
else
    nVariables = max_iter;
end    
 
sel_variables    = nan(nVariables,1);
for i = 1 : max_iter-1
    thisIter = ['iter_',num2str(i)];
    sel_variables(i) = result_iis.(thisIter).best_SISO(1);
end

% Cumulated R2 of the MISO model
R2    = nan(nVariables,1);
for i = 1 : nVariables
    thisIter = ['iter_',num2str(i)];
    R2(i) = result_iis.(thisIter).MISO.cross_validation.performance.Rt2_val_pred_mean;
end
deltaR2 = [R2(1) ; diff(R2)];

% Plotting
figure; 

bar(1:nVariables,deltaR2,'FaceColor','b'); hold on;
plot(R2,'o-','Color','k','LineWidth',...
    1, 'MarkerSize', 8, 'MarkerFaceColor', 'w',...
    'MarkerEdgeColor', 'k'); grid on;
axis([0.5 5.5 0 1.0]);
set(gca,'XTick',1:nVariables); 
xLabels = arrayfun(@(x) {num2str(x)},sel_variables);
set(gca,'XTickLabel', xLabels,'Ylim',[0.00 1.0]);
xlabel('selected variables'); ylabel('R^2');
title('IIS');

 
% This code has been written by Stefano Galelli and Riccardo Taormina.