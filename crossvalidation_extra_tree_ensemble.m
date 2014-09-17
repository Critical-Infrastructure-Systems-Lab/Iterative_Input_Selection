function [model] = crossvalidation_extra_tree_ensemble(subset,M,k,nmin,ns,flag)


% This function cross-validate an ensemble of Exra-Trees 
%
% Inputs: 
% subset = observations
% M      = number of trees in the ensemble
% k      = number of random cut-directions 
% nmin   = minimum number of points per leaf 
% ns     = number of folds in the k-fold cross-validation process 
% flag   = if flag == 1, the model is then evaluated (and saved) on the
% full dataset
%
% Output: 
% model  = structure containing models and performance 


% 0) SET THE PROBLEM PARAMETERS FOR THE ENSEMBLE CROSS-VALIDATION

% Number of lines characterizing an alternative (a single fold)
l = floor(length(subset)/ns);

% Re-define the subset matrix
subset = subset(1:l*ns,:);

% C-ExtraTrees algorithm parameters
rtensparam=init_extra_trees();
rtensparam.nbterms=M;
rtensparam.rtparam.extratreesk=k;
rtensparam.rtparam.nmin = nmin;
    


% 1) INITIALIZATION OF THE OUTPUT VARIABLES 

% Initialize R2 AND RMSE VECTORS
Rt2_cal_pred = zeros(ns,1); 
Rt2_val_pred = zeros(ns,1); 

% Initialize the function output
model.cross_validation.performance = [];


% 2) MODEL CONSTRUCTION AND EVALUATION OF THE PERFORMANCES (k-fold cross-validation)
% Counter
% disp('Start cross-validation:')

for i = 1:ns

    % Counter
    % disp('Start cross-validation:'); disp(i);

    % Define the calibration and validation data-set
    % Calibration
    if (i > 1) && (i < ns)
        subset_tar = [subset(i*l+1:end,:) ; subset(1:(i-1)*l,:)];
    else if i == 1
            subset_tar = subset(i*l+1:end,:);
        else
            subset_tar = subset(1:(i-1)*l,:);
        end
    end
    % Validation
    subset_val = subset((i-1)*l+1:i*l,:);
    
    % datasets
    X1  = single(subset_tar(:,1:end-1));
    Y1  = single(subset_tar(:,end));
    ls1 = int32(1:size(subset_tar,1));    
    X2  = single(subset_val(:,1:end-1));    
        
    % Ensemble building + test the ensemble on the calibration and validation dataset
    evalc('[finalResult_val_pred temp1 temp2 finalResult_cal_pred] = rtenslearn_c(X1,Y1,ls1,[],rtensparam,X2,0)');
    Rt2_cal_pred(i)      = Rt2_fit(subset_tar(:,end),finalResult_cal_pred);                
    Rt2_val_pred(i)        = Rt2_fit(subset_val(:,end),finalResult_val_pred);

end

% Average R2
model.cross_validation.performance.Rt2_cal_pred = Rt2_cal_pred;
model.cross_validation.performance.Rt2_val_pred = Rt2_val_pred;
model.cross_validation.performance.Rt2_cal_pred_mean = mean(Rt2_cal_pred);
model.cross_validation.performance.Rt2_val_pred_mean = mean(Rt2_val_pred);


% 3) MODEL CONSTRUCTION ON THE WHOLE DATA-SET

% Check if is necessary to test the model on the whole data-set
if flag == 1

    % Add new fields to the function output
    model.complete_model.ensemble      = [];
    model.complete_model.trajectories  = [];
    model.complete_model.performance   = [];

    % Counter
    % disp('Building and testing the final model');

    % Model construction
    X1  = single(subset(:,1:end-1));
    Y1  = single(subset(:,end));
    ls1 = int32(1:size(subset,1));
    evalc('[temp0 temp1 ensemble finalResult_pred] = rtenslearn_c(X1,Y1,ls1,[],rtensparam,X2,0)');
    model.complete_model.ensemble = ensemble;
    model.complete_model.trajectories = finalResult_pred;

    % Evaluate R2              
    model.complete_model.performance.Rt2   = Rt2_fit(subset(:,end),finalResult_pred);

else
    
    return
    
end


% This code has been written by Stefano Galelli and Riccardo Taormina.
 









