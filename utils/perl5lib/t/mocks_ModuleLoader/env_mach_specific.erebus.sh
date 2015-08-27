#!/usr/bin/env sh -f 
#===============================================================================
# Automatically generated module settings for erebus
# DO NOT EDIT THIS FILE DIRECTLY!  Please edit env_mach_specific.xml 
# in your CASEROOT. This file is overwritten every time modules are loaded!
#===============================================================================

.  /glade/apps/opt/lmod/lmod/init/sh
module purge  
module load ncarenv/0.0 
module load ncarbinlibs/0.0 
if [ "$COMPILER" = "intel" ]
then
	module load intel/12.1.4
fi
if [ "$COMPILER" = "pgi" ]
then
	module load pgi/12.5
fi
if [ "$COMPILER" = "gnu" ]
then
	module load gnu/4.7.0
fi
if [ "$COMPILER" = "pathscale" ]
then
	module load pathscale/4.0.12.1
fi
module load ncarcompilers/1.0 
module load netcdf-mpi/4.2 
module load pnetcdf/1.3.0 
