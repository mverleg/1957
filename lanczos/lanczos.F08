      !!
      !! Construct the Lanczos symmetric tridiagonal approximation matrix for a given
      !! Hermitian operation which should satisfy `mat_apply_iface`.
      !! Can also get the highest eigenvalue, assuming it's bigger than the lowest one.
      !!
      !! This code (and possibly newer versions) as well as tests are available from:
      !!   https://github.com/mverleg/1957/tree/master/lanczos
      !!
      module lanczos_mod
          use blas, only: ddot, dnrm2
          use lapack, only: dsterf, dsyev
          use, intrinsic :: iso_fortran_env, only: stderr=>error_unit

          implicit none
          private
          public lanczos_mat, lanczos_range, lanczos_max, mat_apply_iface

          !! Interface of the function that multiplies the matrix and the vector
          interface
              subroutine mat_apply_iface(matdim, invec, outvec)
                  integer, intent(in) :: matdim
                  REAL(kind=8), dimension(matdim), intent( in) ::  invec
                  REAL(kind=8), dimension(matdim), intent(out) :: outvec
              end subroutine mat_apply_iface
          end interface

          contains

          subroutine lanczos_mat(nriter, matdim, mat_apply, res_diag, res_offdiag)
              !!
              !! Get the Lanczos tridiagonal approximate matrix.
              !! https://en.wikipedia.org/w/index.php?title=Lanczos_algorithm&oldid=718084622#The_algorithm
              !!
              !! Number of iterations & size of Krylov subspace:
              integer, intent(in) :: nriter
              !! Dimensions of the square matrix & length of the vectors used:
              !! (Leading dimension (LD*) should be equal to matdim)
              integer, intent(in) :: matdim
              !! Subroutine to apply the matrix (should follow the interface):
              procedure (mat_apply_iface) :: mat_apply
              !! The result is a tridiagonal symmetric matrix, stored in two vectors:
              REAL(kind=8), dimension(nriter), intent(out) :: res_diag
              REAL(kind=8), dimension(nriter - 1), intent(out) :: res_offdiag
              !! Internal variables:
              REAL(kind=8), dimension(matdim) :: v_current, v_prev, work_vec, diff
              integer :: k

              v_current = 1.0d0
              ! call RANDOM_NUMBER(v_current)
              ! write(*, *) 'v', v_current(:5)
              v_current = v_current / dnrm2(matdim, v_current, 1)

              do k = 1, nriter
                  ! write (*, *) 'step', k
                  call mat_apply(matdim, v_current, work_vec)
                  res_diag(k)    = ddot(matdim, work_vec, 1, v_current, 1)
                  if (k == nriter) exit
                  diff = - res_diag(k) * v_current
                  if (k > 1) diff = diff - res_offdiag(k-1) * v_prev
                  work_vec = work_vec + diff
                  res_offdiag(k) = dnrm2(matdim, work_vec, 1)
                  v_prev = v_current
                  v_current = work_vec / res_offdiag(k)
              enddo
          end subroutine lanczos_mat

          subroutine lanczos_range(matdim, mat_apply, mi, ma, info, nriter)
              !!
              !! Construct the tridigaonal approximation (lanczos_mat)
              !! and get the extreme eigenvalues.
              !!
              !! Function to apply the matrix (should follow the interface):
              procedure (mat_apply_iface) :: mat_apply
              integer, intent(in) :: matdim
              REAL(kind=8), intent(out) :: mi, ma
              integer, optional, intent(in) :: nriter
              REAL(kind=8), dimension(:), allocatable :: res_diag_and_ev
              REAL(kind=8), dimension(:), allocatable :: res_offdiag
              integer :: stat, info, nriterval

              info = 0
              if (present(nriter)) then
                  nriterval = nriter
              else
                  nriterval = 5
              endif
              allocate (res_diag_and_ev(nriterval), res_offdiag(nriterval - 1))

              !! Get the approximate tridiagonal form
              !! (which will be symmetric if mat_apply is Hermitian)
              call lanczos_mat(nriterval, matdim, mat_apply, res_diag_and_ev, res_offdiag)

              !! Get the eigenvalues (note that the extreme ones is the most reliable)
              call dsterf(nriterval, res_diag_and_ev, res_offdiag, stat)
              if (stat /= 0) then
                  write (stderr, '(1x,a,I0)') 'SDTERF failed with status ', stat
                  info = stat
              endif

              mi = minval(res_diag_and_ev)
              ma = maxval(res_diag_and_ev)
              deallocate (res_diag_and_ev, res_offdiag)
          end subroutine lanczos_range

          REAL(kind=8) function lanczos_max(matdim, mat_apply, info, nriter) result(ma)
              !!
              !! Construct the tridigaonal approximation (lanczos_mat)
              !! and get the highest eigenvalue (just calls lanczos_range,
              !! exists for backward compatibility).
              !!
              !! Function to apply the matrix (should follow the interface):
              procedure (mat_apply_iface) :: mat_apply
              integer, intent(in) :: matdim
              integer, optional, intent(in) :: nriter
              REAL(kind=8) :: mi
              integer :: info

              call lanczos_range(matdim, mat_apply, mi, ma, info, nriter)
          end function lanczos_max
      end module lanczos_mod


