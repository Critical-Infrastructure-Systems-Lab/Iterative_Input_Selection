function result = perform_IIS(data,M,nmin,ns,p,epsilon,max_iter,flag,verbose,Vflag)

% This function is a wrapper around iterative_input_selection.m,   
% the function implementing the IIS technique using Extra-Trees.                                                         
%                                                                                                                                             
%                                                                         
% data              = dataset;                                            
%                                                                         
% rtensparam        = extra-trees parameters;                             
%                                                                         
% ns                = number of folds for cross validation;               
%                                                                         
% p                 = number of SISO models evaluated at each iteration   
%                    (this number must be smaller than the number of      
%                     candidate inputs);                                  
%                                                                         
% epsilon           = tolerance;                                          
%                                                                         
% max_iter          = maximum number of iterations;   
%
% verbose           = 0 for silent run. 1 for verbose mode 
%
% Vflag     = selection of the type of validation, 
%               1 = k-fold(default)
%               2= repeated random sub-sampling
%
% Outputs
% result   = structure containing the result for each iteration
% LOG      = the original algorithm printout saved to text



% 0) check if p <= number of attributes
natt = size(data,2)-1;

if p > natt
    error(['The number of SISO models evaluated',...
        'has to be < number of candidate inputs'])
end

% 1)  Launch IIS algorithm

% Shuffle the data
data_sh = shuffle_data(data);

% Run the IIS algorithm
if verbose == 0
    evalc('result = iterative_input_selection(data_sh,M,nmin,ns,p,epsilon,max_iter,Vflag)');
else
    result = iterative_input_selection(data_sh,M,nmin,ns,p,epsilon,max_iter,Vflag);
end


% This code has been written by Riccardo Taormina.



        
        

