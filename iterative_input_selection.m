
function [result] = iterative_input_selection(subset,M,nmin,ns,p,epsilon,max_iter)

% This function implements the IIS algorithm
%
% subset   = observations
% M        = number of trees in the ensemble
% nmin     = minimum number of points per leaf 
% ns       = number of folds in the k-fold cross-validation process 
% p        = number of SISO models (it must be smaller than the number of
%            candidate inputs).
% epsilon  = tolerance
% max_iter = maximum number of iterations
%
% Output
% result   = structure containing the result for each iteration%


% 0) SET THE PARAMETERS

% Initialize the counter and the exit condition flag
iter     = 1;    % iterations counter
diff     = 1;    % exit flag 

% Re-define the subset matrix
l = floor(length(subset)/ns);
subset = subset(1:l*ns,:);

% Define the MISO model output
miso_output = subset(:,end);

% Define the set of candidate input variables
input  = subset(:,1:end-1);

% Other variables to be initialized      
miso_input = [];  % initialize an empty set to store the input variables to be selected%


% 1) IIS ALGORITHM
while (diff > epsilon) && (iter <= max_iter)
    
    % Visualize the iteration
    disp('ITERATION:'); disp(iter);
    
    % Define the output variable to be used during the ranking
    if iter == 1 
        rank_output = miso_output; % at the first iteration the MISO model output and ranking output are the same variable%
    else         
        rank_output = residual;    % at the other iterations, the ranking output is the residual of the previous MISO model%
    end
    
    % Define the ranking matrix
    matrix_ranking = [input rank_output];
    
    % Run the feature ranking
    disp('Ranking:');
    k = size(input,2);
    [ranking] = input_ranking(matrix_ranking,M,k,nmin);     
    eval(['result.iter_' num2str(iter) '.ranking' '=' 'ranking;']);
    disp(ranking);
    
    % Select and cross-validate p SISO models (the first p-ranked models)
    disp('Evaluating SISO models:');
    features = ranking(1:p,2);                             % p features to be considered           
    performance = zeros(p,1);	                           % initialize a vector for the performance of the p SISO models%			     
    for i = 1:p
        [siso_model] = crossvalidation_extra_tree_ensemble([subset(:,features(i)) rank_output],M,1,nmin,ns,0);        
		performance(i) = siso_model.cross_validation.performance.Rt2_val_pred_mean;
    end
    eval(['result.iter_' num2str(iter) '.SISO' '=' '[features performance];']);
    disp([features performance]);
    
    % Choose the SISO model with the best performance
	[val,idx_siso] = max(performance);
	best_siso_input = features(idx_siso);
    eval(['result.iter_' num2str(iter) '.best_SISO' '=' '[best_siso_input val];']);
    disp('Select variable:'); disp(best_siso_input);
    
    % Check the exit condition
    if (all(miso_input - best_siso_input) == 0) 
        result.exit_condition = 'An input variable was selected twice';
        return
    end
        
	% Build a MISO model with the selected inputs	
    disp('Evaluating MISO model:');
	miso_input = [miso_input best_siso_input];				 
	k = length(miso_input);				 
	[miso_model] = crossvalidation_extra_tree_ensemble([subset(:,miso_input) miso_output],M,k,nmin,ns,1);				 
	eval(['miso_model_' num2str(iter) '= miso_model;']);
    eval(['result.iter_' num2str(iter) '.MISO' '=' 'miso_model;']);
    disp(miso_model.cross_validation.performance.Rt2_val_pred_mean);
	
    % Evaluate the performance of the MISO model and calculate the
    % difference with respect to the previous MISO model
    if iter == 1   % at the first iteration, use a default value
        diff = 1;
    else
        diff = miso_model.cross_validation.performance.Rt2_val_pred_mean - eval(['miso_model_' num2str(iter-1) '.cross_validation.performance.Rt2_val_pred_mean']); 
    end	
        
	% Compute the MISO model residual				 
	residual = miso_output - miso_model.complete_model.trajectories; 				 

	% Update the counter				 
	iter = iter + 1;
    
    % Check the exit condition
    if iter > max_iter 
        result.exit_condition = 'The maximum number of iterations was reached'; 
    end
    if diff <= epsilon  
        result.exit_condition = 'The tolerance epsilon was reached';            
    end
    
end

    

% This code has been written by Stefano Galelli.















