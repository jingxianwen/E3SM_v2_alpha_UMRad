# JOB_QUEUE: regular, debug
./xmlchange --id JOB_QUEUE --val debug

# RUN_TYPE: startup, branch, hybrid
./xmlchange --id RUN_TYPE --val startup

# STOP_OPTIONS: nyears, nmonths, ndays, nhours, nsteps
./xmlchange --id STOP_OPTION --val nhours

# STOP_N: integer
./xmlchange --id STOP_N --val 5

# REST_OPTIONS: nyears, nmonths, ndays, nhours, nsteps
./xmlchange --id REST_OPTION --val nhours

# REST_N: integer
./xmlchange --id REST_N --val 1

# RESUBMIT: integer
#./xmlchange --id RESUBMIT --val 2

# JOB_WALLCLOCK_TIME: hh:mm:ss
./xmlchange --id JOB_WALLCLOCK_TIME --val 00:30:00

# RUN_STARTDATE: YYYY-MM-DD
./xmlchange --id RUN_STARTDATE --val 2000-01-01

