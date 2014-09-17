function [result] = input_ranking(subset,M,k,nmin)

% This function builds an ensemble of Exra-Trees and then ranks 
% the input variables according to their importance
%
% Inputs:
% subset = observations 
% M      = number of trees 
% k      = number of random cut-directions 
% nmin   = minimum number of points per leaf
%
% Output: 
% result = ranked score of each attribute


% RTree-C ExtraTrees algorithm parameters
rtensparam                     = init_extra_trees();
rtensparam.nbterms             = M;
rtensparam.rtparam.extratreesk = k;
rtensparam.rtparam.nmin        = nmin;


% Build and ensemble of Extra Trees and get the score of each variable (for
% each tree)
  
X1  = single(subset(:,1:end-1));
Y1  = single(subset(:,end));
ls1 = int32(1:size(subset,1));
evalc('[ensemble contr] = rtenslearn_c(X1,Y1,ls1,[],rtensparam,0)');

% normalization
contr = contr./sum(contr)*100;

% Rank the variable in decreasing order
[X,I] = sort(contr,1,'descend');
result = [X,I];

% This code has been written by Stefano Galelli and Riccardo Taormina





