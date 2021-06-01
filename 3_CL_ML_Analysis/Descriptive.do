*******Descriptive statistics***********

*Seleccionaron (A o B) o ninguno

	tab selectedchoice if alt ==3
	
*Respondents characteristics

	tabstat total_hectareas edad_ganadero experiencia sexo_ganadero escolaridad agrocalidad_certifi estimado_ingresos,statistics(mean, sd, min, max)
	
*Caracteristicas de la produccion y la granja

	*ha dedicadas para sembrar
		sum dedica_agricultura
	*Sistema de riego utilizado
		tabstat q14_1 q14_2 q14_3 q14_4 q14_5 q14_6,statistics(mean, sd, min, max)
	*Procedencia agua de riego
		mrtab q15_1 q15_2 q15_3 q15_4
		tabstat q15_1 q15_2 q15_3 q15_4,statistics(mean, sd, min, max)
	*Tiene proteccion para las fuentes de agua
		tab q16
	*Tipo de pastoreo
		mrtab q17_1 q17_2 q17_3 q17_4
		tabstat q17_1, statistics(mean, sd)
	*Tipo de fertilizacion utilizada
		tabstat  q18_1 q18_2 q18_3 q18_4, statistics(mean, sd)
	*Manejo de nutrientes
		tabstat q21_1 q21_2 q21_3 q21_4 q21_5 q21_6 q21_7, statistics(mean, sd)
	*Trata de excretas
		mrtab q22_1 q22_2 q22_3 q22_4 q22_5 q22_6
	*Trata de residuos solidos
		mrtab q23_1 q23_2 q23_3 q23_4
		tabstat  q23_1 q23_2 q23_3 q23_4, statistics(sd)
	*que hacen entonces con los residuos solidos
		tab q23_4_TEXT
	*tratamiento de residuos infecciosos
		mrtab q24_1 q24_2 q24_3 q24_4
	*Cabezas de ganado
		tabstat q30, statistics(mean, sd, min, max) 
		
*produccion de leche 
	*Precio del litro de leche vendido
		tabstat q36, statistics(mean, sd, min, max)
	*litros ultimo dia de ordeno
		univar q33
	*Precio de leche vendido
		sum q36
	*a quien vende su produccion
		mrtab q37_1 q37_2 q37_3 q37_4
		tabstat q37_2 q37_3, statistics(mean, sd)
		sum q37_2 q37_3
	*Posee certificacion de agrocalidad
		tab certi_agrocalidad
	*esta al tanto de los beneficios de la certificacion por BMP
		tabstat q45, statistics(mean, sd)
	*Se incrementó el precio al que usted vende, por tener esa certificación?: -
		tab q44
	* en que porcentaje se incrementó
		tab q44_1_TEXT
	* conoce usted los incentivos por tener bmp
		tab q45
	*litros producidos diarimente
		tabstat q33, statistics(mean, p25, p50, p75, p90, p95, p99)

*Tratamiento de residuos solidos e ifecciosos

		tabstat q23_1 q24_2, statistics(mean, sd, min, max)
 *manejo de excretas
 
	 *compostaje
		tabstat q22_3, statistics(mean, sd, min, max)
	 *manure dispertion
		tabstat q22_4, statistics(mean, sd, min, max)
		tabstat q22_1 q22_2 q22_3 q22_4 q22_5 q22_6, statistics(mean, sd, min, max)
		 *cantidad de vacas de ordeno
			*creo residuo_vacas como control de vascas de ordeno >= quw vacas que posee el ganadero
			tabstat q31 if residuo_vacas >=0, statistics(mean, sd, p25, p50, p75, p90, p95, p99, min, max)

*Recibe ayuda del Gobierno

	tabstat q46_5, statistics(mean, sd, min, max)
	mrtab q46_1 q46_2 q46_3 q46_4 q46_5

*Afectacion por covid
	sum q491_1_1 q491_1_2 q491_2_1 q491_2_2 

*Preferencias para el pago de 
	*Quien deberia finaciar la parte que no paga el ganadero
		mrtab q52_1 q52_2 q52_3 q52_4 q52_5 q52_6
	*A que entidad acudiria para finaciar la parte que usted paga. 
		mrtab q53_1 q53_2 q53_3 q53_4




