#!/bin/bash

#---------------
# user setting
#---------------

# model setup
#ACMEROOT="/global/homes/y/yihsuan/model/E3SM-V2_modified"	# source code
ACMEROOT="/global/homes/x/xianwen/model/E3SM-V2-UMRad"	# source code
compset=FC5AV1C-04P2	# set compset
machine=cori-knl	# set machine
grid=ne30_ne30		# set resolution
#queue="debug"
queue="regular"
export project=m2136	# project number to charge

# case name
temp=`date +%m%d%H%M`
#CASEID="E3SM_standard-5days"
#switch="ALLon"
switch="noEmis"
CASEID="E3SMv2_UMRad_iceflag3_AMIP_${switch}"

# case dir
#CASEDIR=/global/cscratch1/sd/yihsuan/E3SM_simulations/${CASEID}
CASEDIR=/global/cscratch1/sd/xianwen/E3SM_simulations/${CASEID}

# code modification
#   The odified codes are in E3SM-V2_modified folder, so set option_code = "F"
#   Also, E3SMv2 doesn't seem to support SourceMods method. It's a bit inconvenient to debug.
#option_code="F"		# use SourceMods
#codedir="/global/homes/y/yihsuan/work/research/E3SM_V2_test/code/src.cam.emis_mc6_rtr2_Scat.${switch}"
#CASEDIR_srccam=$CASEDIR/SourceMods/src.cam
#file_from="$codedir/radiation.F90"
#file_to="$ACMEROOT/components/cam/src/physics/rrtmg/radiation.F90"

#file_emis="/global/cscratch1/sd/yihsuan/data/surface_emissivity_1x1_RRTMG_53deg.nc"

# run specification
STOP_N=6
#STOP_OPTION="nsteps"
#STOP_OPTION="nyears"
STOP_OPTION="nmonths"
#STOP_OPTION="ndays"
nhtfrq=0		# =0, monthly average
			# >0, frequency is input as number of timesteps.
			# <0, frequency is input as number of hours
STARTDATE="0001-01-01"
resubmit=5
walltime="06:00:00"

#------------
# program 
#------------

set -x


  cd $ACMEROOT/cime/scripts || exit 1

  #set CASEDIR=~/ACME/Cases/testing/$machine/$CASEID

  ./create_newcase -case $CASEDIR -mach $machine -project $project -compset $compset -res $grid

  cd $CASEDIR

  ./case.setup > case.setup.log

  ./xmlchange -file env_build.xml CAM_CONFIG_OPTS="-verbose -cosp" -append

  #./xmlchange -file env_run.xml RUN_STARTDATE="0001-01-01",STOP_N="1",STOP_OPTION="ndays",REST_OPTION="ndays",REST_N="5",SAVE_TIMING="FALSE",DOUT_S="FALSE" 
  ./xmlchange -file env_run.xml RUN_STARTDATE=$STARTDATE,STOP_N=$STOP_N,STOP_OPTION=$STOP_OPTION,SAVE_TIMING="FALSE",DOUT_S="FALSE" 

  ./xmlchange JOB_WALLCLOCK_TIME=$walltime
  ./xmlchange RESUBMIT=$resubmit

  if [ $queue -a $queue == "debug" ]; then
    ./xmlchange --id JOB_QUEUE --val 'debug'
  fi 

cat > user_nl_cam << EOF
&cam_inparm
nhtfrq = $nhtfrq
empty_htapes = .false.
fincl1 = 'FLDSC:A'
EOF

  if [ $option_code -a $option_code == "T" ]; then
    if [ -f $file_from ] && [ -f $file_to ]; then
      cp $file_from $file_to || exit 1
    else
      echo "ERROR: [$file_from] and/or [$file_to] does not exist"
      echo "program stop"
      exit 3
    fi

    if [ -d $codedir ] && [ -d $CASEDIR_srccam ]; then
      cp $codedir/* $CASEDIR_srccam || exit 3
    else
      echo "ERROR: code dir [$codedir] does not exist"
      echo "program stop"
      exit 3
    fi
  fi

  ./case.build && echo "Done. Build E3SM" || exit 5

  ./case.submit && echo "Done. submit E3SM" || exit 7

  #scontrol update Partition=debug TimeLimit=00:30:00 JobId=job_id  # switch to debug queue

  exit 0
