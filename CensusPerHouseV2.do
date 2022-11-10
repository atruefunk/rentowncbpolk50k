cd "C:\Users\atrue\Box\PCHTF\Census\ACS\Data"

**#Renters Cost Burden
forvalues y = 2010(1)2020{
	import delimited "ACSDT5Y`y'.B25074-Data.csv", clear

tempfile f`y'
save f`y', replace
clear
}

forvalues y = 2011(1)2013{
	use f`y', clear
drop v203
foreach var of varlist _all {
    rename `var' `=`var'[1]'
}
drop in 1/2
gen year = `y'
tempfile f`y'
save f`y', replace	
}

forvalues y = 2014(1)2020{
	use f`y', clear
drop v259
foreach var of varlist _all {
    rename `var' `=`var'[1]'
}
drop in 1/2
gen year = `y'
tempfile f`y'
save f`y', replace
	
}

use "f2014.dta", clear
forvalues y = 2015(1)2020{
	append using f`y'
	}

rename *, lower

destring b25074_001e -b25074_064e, replace

keep geo_id name year b25074_001e b25074_010e b25074_003e b25074_009e b25074_008e b25074_007e b25074_006e b25074_005e b25074_004e b25074_002e b25074_055e b25074_048e b25074_054e b25074_053e b25074_052e b25074_051e b25074_050e b25074_049e b25074_047e b25074_046e b25074_039e b25074_045e b25074_044e b25074_043e b25074_042e b25074_041e b25074_040e b25074_038e b25074_037e b25074_030e b25074_036e b25074_035e b25074_034e b25074_033e b25074_032e b25074_031e b25074_029e b25074_028e b25074_021e b25074_027e b25074_026e b25074_025e b25074_024e b25074_023e b25074_022e b25074_020e b25074_064e b25074_057e b25074_063e b25074_062e b25074_061e b25074_060e b25074_059e b25074_058e b25074_056e b25074_019e b25074_012e b25074_018e b25074_017e b25074_016e b25074_015e b25074_014e b25074_013e b25074_011e

split geo_id, parse("US") gen(place)

order geo_id place1 place2

gen place = substr(place2,3,7), after(place2)
drop place1 place2

destring place, replace

keep if inlist(place, 1630, 2305, 7390, 14520, 21000, 33060, 39765, 57675, 63525, 79950, 82695, 83910, 86250)
**#Cost Burden Renters

//not calculated-renters
gen nocalcrent = b25074_010e +b25074_019e+ b25074_028e+ b25074_037e 

//Adjusted number of renters
gen adjtotrent = b25074_001e- nocalcrent

//Number of renters income <$50,000
gen i50krent= b25074_002e+ b25074_011e+ b25074_020e +b25074_029e

//Adjusted number of renters incom <50,000
gen adj50krent = i50krent - nocalcrent

//number of renters 30% - 49% MCB
gen mcb50krent = b25074_006e+b25074_008e+b25074_015e+b25074_016e+b25074_017e+b25074_024e+b25074_025e+b25074_026e+b25074_033e+b25074_034e+b25074_035e


//number ofrenters 50% SCB <50,000
gen scb50krent = b25074_009e+b25074_018e+b25074_027e+b25074_036e

//number of renters 30% CB <50,000
gen cb50krent =b25074_006e+b25074_008e+b25074_015e+b25074_016e+b25074_017e+b25074_024e+b25074_025e+b25074_026e+b25074_033e+b25074_034e+b25074_035e+b25074_009e+b25074_018e+b25074_027e+b25074_036e

//Percent 30% - 49% MCB <50,000
gen permcb50krent= (mcb50krent/i50krent)*100

//percent of renters 50% SCB <50,000
gen perscb50krent= (scb50krent/i50krent)*100

//percent of renters 30%+ CB <50,000
gen percb50krent = (cb50krent/i50krent)*100

//percent of renters not cost burdened
gen perncb50krent =100- percb50krent

tempfile renters
save `renters'

**#Owners Cost Burden
forvalues y = 2014(1)2020{
	import delimited "ACSDT5Y`y'.B25095-Data.csv", clear

tempfile f`y'
save f`y', replace
clear
}

forvalues y = 2014(1)2020{
	use f`y', clear
drop v295
foreach var of varlist _all {
    rename `var' `=`var'[1]'
}
drop in 1/2
gen year = `y'
tempfile f`y'
save f`y', replace	
}


use "f2014.dta", clear
forvalues y = 2015(1)2020{
	append using f`y'
	}

rename *, lower

keep geo_id name year b25095_001e b25095_010e b25095_003e b25095_009e b25095_008e b25095_007e b25095_006e b25095_005e b25095_004e b25095_002e b25095_055e b25095_048e b25095_054e b25095_053e b25095_052e b25095_051e b25095_050e b25095_049e b25095_047e b25095_046e b25095_039e b25095_045e b25095_044e b25095_043e b25095_042e b25095_041e b25095_040e b25095_038e b25095_037e b25095_030e b25095_036e b25095_035e b25095_034e b25095_033e b25095_032e b25095_031e b25095_029e b25095_028e b25095_021e b25095_027e b25095_026e b25095_025e b25095_024e b25095_023e b25095_022e b25095_020e b25095_073e b25095_066e b25095_072e b25095_071e b25095_070e b25095_069e b25095_068e b25095_067e b25095_065e b25095_064e b25095_057e b25095_063e b25095_062e b25095_061e b25095_060e b25095_059e b25095_058e b25095_056e b25095_019e b25095_012e b25095_018e b25095_017e b25095_016e b25095_015e b25095_014e b25095_013e b25095_011e

split geo_id, parse("US") gen(place)

order geo_id place1 place2

gen place = substr(place2,3,7), after(place2)
drop place1 place2

destring place, replace

destring b25095_001e - b25095_073e, replace

keep if inlist(place, 1630, 2305, 7390, 14520, 21000, 33060, 39765, 57675, 63525, 79950, 82695, 83910, 86250)

//Number of owners income <$50,000
gen i50kown= b25095_002e+b25095_011e+b25095_020e+b25095_029

//not calculated-owners
gen nocalcown = b25095_010e+b25095_019e+b25095_028e+b25095_037e

//Adjusted number of owners
gen adjtotown = b25095_001e- nocalcown

//Adjusted number of owners income <50,000
gen adj50kown = i50kown - nocalcown

//number of owners 30% - 49% MCB
gen mcb50kown = b25095_006e+b25095_007e+b25095_008e+b25095_015e+b25095_016e+b25095_017e+b25095_024e+b25095_025e+b25095_026e+b25095_033e+b25095_034e+b25095_035e


//number ofowners 50% SCB <50,000
gen scb50kown = b25095_009e+b25095_018e+b25095_027e+b25095_036e

//number of owners 30% CB <50,000
gen cb50kown =b25095_006e+b25095_007e+b25095_008e+b25095_009e+b25095_015e+b25095_016e+b25095_017e+b25095_018e+b25095_024e+b25095_025e+b25095_026e+b25095_027e+b25095_033e+b25095_034e+b25095_035e+b25095_036e

//Percent Owners 30% - 49% MCB <50,000
gen permcb50kown= (mcb50kown/i50kown)*100

//percent of owners 50% SCB <50,000
gen perscb50kown= (scb50kown/i50kown)*100

//percent of owners 30%+ CB <50,000
gen percb50kown = (cb50kown/i50kown)*100

//percent of owners not cost burdened
gen perncb50kown =100- percb50kown

merge 1:1 place year using `renters', nogen

qui do "C:\Users\atrue\Box\PCHTF\Census\ACS\CensusPercHouseLabel221107.do"

keep geo_id place b25074_001e year nocalcrent adjtotrent i50krent adj50krent mcb50krent scb50krent cb50krent permcb50krent perscb50krent percb50krent perncb50krent b25095_001e i50kown nocalcown adjtotown adj50kown mcb50kown scb50kown cb50kown permcb50kown perscb50kown percb50kown perncb50kown b25074_001e

export excel using "CostBurdenRentersOwners2014-2020", firstrow(varlabels)
