Iterative_Input_Selection
===========================================

The Iterative_Input_Selection toolbox is a MatLab / C implementation of the Iterative Input Selection (IIS) algorithm proposed by Galelli and Castelletti (2013). The underlying Extremely Randomized Trees (Extra-Trees) models are implemented using the "rtree-c" code by P. Geurts (http://www.montefiore.ulg.ac.be/~geurts/Software.html) to improve computational efficiency. 

The original version, entirely written in MATLAB, is available at https://github.com/Critical-Infrastructure-Systems-Lab/MATLAB_Iterative_Input_Selection.

Contents:
* `script_example.m`: show how to use the available functions on a sample dataset (Friedman_dataset.txt).
* `crossvalidation_extra_tree_ensemble.m`: run a k-fold cross-validation for an ensemble of Extra-Trees.
* `input_ranking.m`: rank the input variables.
* `iterative_input_selection.m`: run the IIS algorithm.
* `perform_IIS.m`: wrapper function used to launch iterative_input_selection.m
* `shuffle_data.m`: shuffle the observations of the sample dataset.
* `Rt2_fit.m`: compute the coefficient of determination R2.
* `visualize_inputSel.m` : visualize the results obtained with multiple runs of the IIS algorithm.
* `Friedman_dataset.txt`: sample dataset, with 10 candidate inputs (first 10 columns) and 1 output (last column). The observations, arranged by rows, are 250.
* `INSTALL.txt`: text file containing step-by-step instructions for modifying and compiling the C source code.



Based on work from the following papers:

- Galelli, S., and A. Castelletti (2013a), Tree-based iterative input variable selection for hydrological modeling, Water Resour. Res., 49(7), 4295-4310 ([Link to Paper](http://onlinelibrary.wiley.com/doi/10.1002/wrcr.20339/abstract)).
- Galelli, S., and A. Castelletti (2013b), Assessing the predictive capability of randomized tree-based ensembles in streamflow modelling, Hydrol. Earth Syst. Sci., 17, 2669-2684 ([Link to Paper](http://www.hydrol-earth-syst-sci.net/17/2669/2013/hess-17-2669-2013.html)).
- Geurts, P., D. Ernst, and L. Wehenkel (2006), Extremely randomized trees, Mach. Learn., 63(1), 3-42 ([Link to Paper](http://link.springer.com/article/10.1007/s10994-006-6226-1)).

Acknowledgements: to Dr. Matteo Giuliani (Politecnico di Milano).

Copyright 2014 Stefano Galelli and Riccardo Taormina

This file is part of Iterative_Input_Selection

Iterative_Input_Selection is free software: you can redistribute
it and/or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This code is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Iterative_Input_Selection. If not, see <http://www.gnu.org/licenses/>.
