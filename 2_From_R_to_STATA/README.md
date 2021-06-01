# Obtaining the data base for further analysis.

This section follows the code written by Sylvain Weber in "A Step-by-Step Procedure to Implement Discrete Choice Experiments in Qualtrics" with the respective changes.

* **ExpDesign.xlsx** 
  This file was created based on part_factorial_design_long_form.csv, here we have to take into account several considerations: 
  1. The alternatives for attributes 1-4 were increased by one unit in order to follow the implementation of Sylvain Weber's work, in which the levels present dummy coding of 1 and 2 and not 1 and 0 as the R script gives us.

  2. In attribute 4 we modify the coding, because in this case we have the alternative skills or none (status quo).
But the alternative none will be coded with 0 (status quo).

  3. For attribute 5 we change the alternative to its corresponding numerical representation

  4. And we add option 3 none of the above for each card (choice task).

* **FinalSurveyData.csv** file containing the answers submitted by the farmers to the DCE, in the format of Sylvain Weber's paper. 
* ```ShapeQualtricsData.do``` is the script that links the partional design and the farmers' responses to the DCE, as well as transforms the database for further analysis.
* **help_file1.dta** and **help_file2.dta** for more information check the previous do file 
* **DCE_Machachi.dta** the final result of ```ShapeQualtricsData.do```