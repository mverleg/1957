      !!
      !! Test Lanczos range estimation on a small matrix and check the result.
      !!
      module lanczos_test_mod
          private
          public test_all
          contains

          subroutine test_all()
              use lanczos, only: lanczos_max, mat_apply_iface
              use blas, only: ddot, dsymv
              use lapack, only: dsyev
              use, intrinsic :: iso_fortran_env, only: stderr=>error_unit

              implicit none

              integer, parameter :: M = 200
              integer :: p, q, stat
              REAL(kind=8), dimension(M, M) :: matrix, mcopy
              REAL(kind=8), dimension(M) :: eigenvals
              REAL(kind=8), dimension(6*M) :: dwork
              REAL(kind=8) :: ma

              !! Create the matrix
              call RANDOM_NUMBER(matrix)
              do p=1,M
                  do q=1,M
                      matrix(p, q) = sqrt(abs(p - q)**1.5 + (p + q) / 2)
                  enddo
              enddo
              do p = 1, min(M, 10)
                  write(*, '(1x,10(f8.3))') matrix(:10, p)
              enddo
              if (m > 10) write(*, '(4x,a/)') '...rest of matrix not printed...'

              !! Reference explicit calculation
              write(*, *) 'ddot', DDOT(M, matrix(:, 1), 1, matrix(:, 2), 1)
              mcopy = matrix
              call DSYEV ('N', 'U', M, mcopy, M, eigenvals, dwork, 6*M, stat)
              if (stat /= 0) then
                  write (stderr, '(1x,a,I0)') 'DSYEVR failed with status ', stat
                  stop 1
              endif
              write (*, '(1x,a,1x,es24.16e3)') 'lapack  min', minval(eigenvals)
              write (*, '(1x,a,1x,es24.16e3)') 'lapack  max', maxval(eigenvals)

              !! Get the answer from Lanczos
              ma = lanczos_max(M, mat_vec_mult, stat)
              write (*, '(1x,a,1x,es24.16e3)') 'lanczos max', ma

              contains
              subroutine mat_vec_mult(matdim, invec, outvec)
                  !! Wrapper function that calls the potential (satisfies mat_apply_iface).
                  integer, intent(in) :: matdim
                  REAL(kind=8), dimension(matdim), intent( in) ::  invec
                  REAL(kind=8), dimension(matdim), intent(out) :: outvec
                  call dsymv('U', matdim, 1.0d0, matrix, matdim, invec, 1, 0.0d0, outvec, 1)
              end subroutine mat_vec_mult
          end subroutine test_all
      end module lanczos_test_mod

      !! gfortran wants this in a separate file
      program lanczos_test
          use lanczos_test_mod, only: test_all

          implicit none

          call test_all()
      end program lanczos_test



