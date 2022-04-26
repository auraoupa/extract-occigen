# Scripts for extracting and computing derived quantities of NEMO outputs on occigen

In this repository are gathered some bash scripts that allows to perform :

  - extractions of variable and/or sub-regions (horizontal, vertical, temporal)
  - computations of derived quantities (means, degradation, EKE, vorticity, etc ...)

from NEMO outputs.

The scripts are organized as follow : 
  -  scripts which name begins with script_ are the base script to perform an operation (for instance : [this script](https://github.com/auraoupa/extract-occigen/blob/main/script_extract_surf_NATL60_1month.ksh) extract surface fields of NATL60 output for a given month)
  -  scripts which name begins with make_ are a wrapper of the previous one, applying it to a particular case  (for instance [this script](https://github.com/auraoupa/extract-occigen/blob/main/script_extract_surf_eNATL60-BLB002_REG_VAR_MONTH.ksh) apply [this base script](https://github.com/auraoupa/extract-occigen/blob/main/script_extract_surf_eNATL60_1month.ksh) for a particular simulation)
  -  scripts which name begins with job_ are a wrapper of the previous one, distributing the previous ones on different CPU cores so that it is computed for the whole period, different variables and/or different region in parallel (for instance [this job](https://github.com/auraoupa/extract-occigen/blob/main/job_extract_3D_eNATL60-EUROSEA.ksh) parallelizes the extraction of 5 variables for 12 month and 2 regions on 120 cores) 
