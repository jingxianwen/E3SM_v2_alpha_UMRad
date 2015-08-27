#!/usr/bin/env csh -f 
#===============================================================================
# Automatically generated module settings for brutus
# DO NOT EDIT THIS FILE DIRECTLY!  Please edit env_mach_specific.xml 
# in your CASEROOT. This file is overwritten every time modules are loaded!
#===============================================================================

source /etc/profile.d/modules.csh
module purge 
if ( $COMPILER == "intel" ) then
	module load intel/10.1.018
endif
if ( $COMPILER == "pgi" ) then
	module load pgi/9.0-1
endif
if ( $MPILIB == "mpich" ) then
	module load mvapich2/1.4rc2
endif
if ( $MPILIB == "openmpi" ) then
	module load open_mpi/1.4.1
endif
module load netcdf/4.0.1
