global n = 500
global criticalz = invnormal(0.975)
global sigma = sqrt(0.05*0.95)
* Define program to sample from a population with 5 percent unemployment
program define ci, rclass
clear
set obs $n
gen unemp = (runiform(0,1) < 0.05)
sum unemp
return scalar xbar = r(mean)
return scalar ci_low = r(mean) - $criticalz * $sigma / sqrt($n)
return scalar ci_high = r(mean) + $criticalz * $sigma / sqrt($n)
end
* Take 100 samples and plot confidence intervals
simulate xbar = r(xbar) ci_low = r(ci_low) ci_high = r(ci_high), reps(100): ci
gen sample = _n
twoway (scatter xbar sample, msymbol(smcircle) msize(small)) (rcap ci_high ci_low
sample, msize(small)), scheme(tufte) legend(off) yline(0.05) ytitle(Estimated
unemployment rate and 95% CI) xtitle(Sample number) yscale(range(0 0.1)) ylabel
(0(0.025)0.1)
graph export ci.pdf, replace
