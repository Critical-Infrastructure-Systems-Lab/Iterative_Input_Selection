MATLAB_IterativeInputSelection_with_Rtree-c
===========================================================================================

The MATLAB_IterativeInputSelection_with_Rtree-c toolbox is a MatLab implementation of the 
Iterative Input Selection (IIS) algorithm proposed by Galelli and Castelletti (2013). 
The underlying Extremely Randomized Trees (Extra-Trees) models are implemented using the 
"rtree-c" code by P. Geurts (http://www.montefiore.ulg.ac.be/~geurts/Software.html) 
to improve computational efficiency. 



Here follow the instructions to compile the rtree-c functions needed to run the IIS. 

1) Download and unpack Geurts' Regression tree package, which is available at 
	
	http://www.montefiore.ulg.ac.be/~geurts/Softs/RT-december-2010.tgz

2) Enter the "rtree-c" folder and modify the original "rtenslearn_c.c" source according to

	For MAC/LINUX/UNIX users:
	
	add the following code between line 507 and 508
	
	if (nlhs>3) 
	{/* return the predictions on the train dataset */
		if (verbose==1) 
		{
			mexPrintf("Predictions on the train dataset...");
		}
		plhs[3]=compute_ts_predictions_matlab_multiregr(mxGetM(prhs[0]),(float *)mxGetPr(prhs[0]));
		if (verbose==1) 
		{
			  mexPrintf("\n");
		}
	} 
	
	For WINDOWS users:
	
	do the same modifications as for MAC/LINUX/UNIX users, and in addition cut the declaration
		
		char *fname;
	
	in line 117 and paste it before line 115. 
	
	
3) Make sure that a third-party C compiler, supported by the MATLAB version being used, 
	has been installed in the machine. 
	See http://www.mathworks.com/support/compilers/ for further information.
	
4) Open MATLAB and initialize MEX compiling by running  

    mex -setup
	
	and selecting a compiler among the available ones. Refer to 3) if no compilers are available.	
	
5) Set the"rtree-c" folder as MATLAB working directory, and compile the function 
	rtree-c/ok3enslearn_mo_c.c using the command 

    mex rtenslearn_c.c	
	
6) Copy the resulting mex file into the main directory of the Regression tree package ('..../RT')

7) Add the main directory ('..../RT') to your MATLAB PATH and run the "script_example" 
	provided with MATLAB_IterativeInputSelection_with_Rtree-c to check that everything works 


	
		
===========================================================================================

Copyright 2014 Stefano Galelli and Riccardo Taormina.
Contacts: 
	stefano_galelli@sutd.edu.sg (http://people.sutd.edu.sg/~stefano_galelli/index.html).
	riccardo.taormina@connect.polyu.hk

This file is part of MATLAB_IterativeInputSelection_with_Rtree-c

MATLAB_IterativeInputSelection_with_Rtree-c is free software: you can redistribute
it and/or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This code is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with MATLAB_IterativeInputSelection_with_Rtree-c. If not, see <http://www.gnu.org/licenses/>.
