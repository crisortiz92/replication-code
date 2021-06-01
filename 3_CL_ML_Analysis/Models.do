/*Condittional and mixed logit models*/

timer clear 1
timer on 1

	*Global variables
qui global prod ayudaGob montIncome usoSistemaFinanciero 
qui global socioec separado indigena secundaria edad

qui eststo est1:cmclogit selectedchoice att13 att22 att32 att42 att5, noconstant vce(oim) basealternative(3)
	*WTP CL only att
	wtp att5 att13 att22 att32 att42, level(90)
qui eststo est2:cmclogit selectedchoice att13 att22 att32 att42 att5, casevars($prod) noconstant vce(oim) basealternative(3)
qui eststo est3:cmclogit selectedchoice att13 att22 att32 att42 att5, casevars($prod $socioec) noconstant vce(oim) basealternative(3)

qui eststo est4:cmxtmixlogit selectedchoice att13 att22 att32 att42, random(att5, correlated) noconstant vce(oim) basealternative(3)
	*WTP ML only att
	wtp att5 att13 att22 att32 att42, level(90)
qui eststo est5:cmxtmixlogit selectedchoice att13 att22 att32 att42, random(att5, correlated) casevars($prod) noconstant vce(oim) basealternative(3)
	*WTP ML + prod variables
	wtp att5 att13 att22 att32 att42, level(90)
qui eststo est6:cmxtmixlogit selectedchoice att13 att22 att32 att42, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
	*WTP ML + prod, socieco variables
	wtp att5 att13 att22 att32 att42, level(90)

estimates table est*,se stats(N, ll, aic, bic) 
estimates table est*, stats(N, ll, aic, bic)  star(.1 .05 .01)

********WTP restringido
qui eststo wtp1: cmxtmixlogit selectedchoice att13 att22 att32 att42 if sexo==0, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *WTP Solo Mujeres
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp2: cmxtmixlogit selectedchoice att13 att22 att32 att42 if sexo==1, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *WTP Solo Hombres
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp3: cmxtmixlogit selectedchoice att13 att22 att32 att42 if covidReduccionProduc != 0, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *Reduccion por Covid
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp4: cmxtmixlogit selectedchoice att13 att22 att32 att42 if covidReduccionProduc == 0, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *No Reduccion por covid 
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp5: cmxtmixlogit selectedchoice att13 att22 att32 att42 if distancia15==0, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    **no vive a mas de 15min en carro del centro urbano mas cercano
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp6: cmxtmixlogit selectedchoice att13 att22 att32 att42 if distancia15==1, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *Si vive a mas de 15 minutos
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp7: cmxtmixlogit selectedchoice att13 att22 att32 att42 if escolaridad == 1, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *Escolaridad >=12 anios
    wtp att5 att13 att22 att32 att42, level(90)
qui eststo wtp8: cmxtmixlogit selectedchoice att13 att22 att32 att42 if escolaridad == 0, random(att5, correlated) casevars($prod $socioec) noconstant vce(oim) basealternative(3)
    *Escolaridad <12 anios
    wtp att5 att13 att22 att32 att42, level(90)

timer off 1
*execution time in seconds
timer list 1