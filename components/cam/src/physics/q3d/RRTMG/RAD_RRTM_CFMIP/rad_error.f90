subroutine rad_error()
  implicit none
  
!JUNG  include "mpif.h"
!JUNG  integer mpierr
  
!JUNG  call mpi_finalize(mpierr)

  write(*,*) 'Error encountered in GCSS-CFMIP interface to RRTM '
  write(*,*) 'Stopping model...'

  ! PORTABILITY NOTE: EITHER CHANGE THE FOLLOWING TO STOP
  !   OR CALL YOUR OWN ROUTINE THAT STOPS THE MODEL NICELY.
  
  !call task_abort()
   STOP

end subroutine rad_error
