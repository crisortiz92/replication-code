
*******************************************************************************************/
clear all
cd "C:\Users\Cris\Desktop\Replicate_Code\2_From_R_to_STATA"
import delimited "FinalSurveyData.csv"
set more off

ren responseid id // ResponseID from Qualtrics
*keep id block ce_* // retain variables related to DCE only
ren ce_choicetask*_1 choice* // remove the initial "ce_", the final "_1", and rename all choicetask# variables to choice#
destring *, replace // all variables were stored as string; transformed to numeric


reshape long choice, i(id) j(choicetask)


drop if (block==1 & !inrange(choicetask,1,4)) | (block==2 & !inrange(choicetask,5,8)) | (block==3 & !inrange(choicetask,9,12))

save help_file1, replace

*** Reshape dataset to have 1 observation = 1 alternative ***
*Triplicate observations and create alt variable
expand 2, gen(alt)
replace alt=alt+1
save help_file2, replace
clear

use help_file1
gen alt = 0
replace alt=alt+3
save help_file1, replace

clear
use help_file2
append using help_file1

*Create binary variable indicating which alternative was selected
gen selectedchoice = choice == alt


*** Include information from the experimental design ***
preserve
*Import experimental design from spreadsheet, alternative by alternative
forv i = 1/3 {
	#d ;
	import excel using ./ExpDesign.xlsx, clear 
		sheet(ExperimentalDesign) 
		cellrange(A1:Q13)
		first
	;
	#d cr
	keep block choicetask A`i'_*
	gen alt = `i'
	ren A`i'_? att?
	tempfile alt`i'
	save `alt`i'', replace
}
restore

merge m:1 block choicetask alt using `alt1', nogen update
merge m:1 block choicetask alt using `alt2', nogen update
merge m:1 block choicetask alt using `alt3', nogen update 

*Rearrange variables and observations
order id block choicetask alt choice
sort id block choicetask alt




*Attribute 1
la var att1 "Sistema de Riego"
#d ;
la def riego 
	1 "Microaspersores"
	2 "Lluvia Solida"
	0 "Ninguno"
	
;
#d cr
la val att1 riego

*Attribute 2
la var att2 "Excretas"
#d ;
la def purines 
	1 "Compostera"
	2 "Dispersion"
	0 "Ninguno"
;
#d cr
la val att2 purines


*Attribute 3
la var att3 "Manejo de Residuos"
#d ;
la def reciclaje 
	1 "Centros de acopio"
	2 "Contenedores Municipales"
	0 "Ninguno"
	
;
#d cr
la val att3 reciclaje

*Attribute 4
la var att4 "Cooperacion entre ganaderos"
#d ;
la def cooperacion 
	1 "Capacitaciones"
	0 "Ninguno"
	
	
;
#d cr
la val att4 cooperacion


*Merge questionnaire dataset to our CE
merge m:m id using questionnaireMachachi

* Declare data to be choice model data
cmset id choicetask alt 
cmchoiceset
cmtab, choice(selectedchoice) 

* generate dummy variables from discrete variables

tabulate att1, generate(att1)
tabulate att2, generate(att2)
tabulate att3, generate(att3)
tabulate att4, generate(att4)

*We then save the generated database for further analysis.
*That's all!!!!

save DCE_Machachi, replace

