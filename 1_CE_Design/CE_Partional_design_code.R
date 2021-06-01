    
                # C.E. design full implementation
                # By Cristhian Ortiz - USFQ


# 1) Cleaning workspace and memory cache 

    if(!is.null(dev.list())) dev.off()
    memory.size(max=F)
    gc()
    cat("\014") 
    rm(list=ls())


# Install necessary packages

    #install.packages("idefix")
    #install.packages("shiny") 
    #install.packages("radiant")

# 2) Call the packages
    
    library(radiant)
    library(shiny)
    library(idefix)
    
    options(max.print=999999)
    getwd()


	  "To check the radian package, we replicate the results obtained 
	  by Yehouenou (2020) https://doi.org/10.1017/age.2020.5  
	  (3 attributes of 3 levels and 2 attribute of 2 levels).
	  
	  They found a factorial design with a D-efficiency of 97.57. 
	  This design included 18 choice sets blocked choices
	  
	  Using radiant we obtained a D_efficient of 97.3 in 18 sets of blocked choices
	  "

	# Yehouenou's paper (3 three-level and 2 two-level)

	  result_paper <- doe(
		factors = c(
		  "Agency; FDACS; FDEP; USDA", 
		  "length_contract; 5; 10; 15", 
		  "verification_process; self; on_farm_visit", 
		  "cost_included; initialOnly; initial+anual", 
		  "shared_cost; $30; $50; $70"), seed = 1234)

	  #summary(result_1, eff = TRUE, part = TRUE, full = TRUE)
	  result_paper$eff
	  


# 3) Select optimal D-efficient and # choice sets    

	"
	Running several simulations we found that for our case
	four 2-level attributes and one 3-level attribute 
	gave us the best D-efficient.
	"

    result <- doe(
        factors = c(
            "SistemaRiego; Microaspersores; lluviaSolida", 
            "TratamientoExcretas; Compostera; DispersionEstiercol", 
            "ManejoSolidos; ContenedoresMunicipales; CentrosAcopio", 
            "CoopGanaderos; Capacitaciones; Ninguna", 
            "Cost; 30%; 40%; 70%"), seed = 1234)

    summary(result, eff = TRUE, part = TRUE, full = TRUE)

    #Select Optimal D-efficient

    result$eff

#  4) Getting the partial design 

    #a) Four attributes with 2 levels and one attribute with three levels
    
        at.lvls.m <- c(2, 2, 2, 2, 3)
        
    #4 1-4th attributes are dummies (D) and 5th is continue (C)
        
        c.type.m <- c("D", "D", "D", "D", "C")
    
    #Levels for continuous attributes in the same order
        
        con.lvls.m <- list(c(0,1,2))
        cand.set.m <- Profiles(lvls = at.lvls.m, coding = c.type.m, c.lvls = con.lvls.m )
        mu <- c(0.8, 0.2, -0.3, -0.2, 0.7) #default calibration values in package
        v <- diag(length(mu))
        ps <- MASS::mvrnorm(n = 25, mu = mu, Sigma = v)
        a <- Modfed(cand.set = cand.set.m, n.sets = 12, n.alts = 2, #n.set selected as optimal D-eff result in part 3
                    alt.cte = c(0, 0), parallel = TRUE, par.draws = ps)
        
    #Saving the results in .csv file in the current working directory
        
        write.csv(a$design, file = "part_factorial_design.csv")
        

