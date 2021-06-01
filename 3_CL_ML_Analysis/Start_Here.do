	/*
			Stata Replication code
		for Discrete Choice Experiment for
		Water Conservation Practices in Mejia, Ecuador
				Working Paper	
	*/
	
	*Code works for stata versions 16 and higher
	version 16:
	
	*Set directory
	
	cd "C:\Users\Cris\Desktop\Replicate_Code\3_CL_ML_Analysis"
	
	*Data set
	
		use ..\2_From_R_to_STATA\DCE_Machachi.dta
	
	*Descriptive statistics
	
		do Descriptive.do
	
	*Replication Models (Estimated execution time 6 minutes)
			
		do Models.do
