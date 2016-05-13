
module my_utils
    use lapack, only: DGEEV, DSTEV

    implicit none
    private
    public dp, do_setup, write_csv

    integer, parameter:: dp=kind(0.d0)

    interface write_csv
        module procedure write_csv_d2, write_csv_i2, write_csv_dd1, write_csv_ii1, write_csv_id1, &
            laplacian, print_vector, print_matrix
    end interface

    contains

    subroutine do_setup()
        !!
        !! Do some initial setup, like printing general info and checking arguments.
        !!
        use iso_fortran_env, only: compiler_version, compiler_options

        ! real(dp) :: flt = 7
        integer :: k
        character(len=20) :: arg
        character(len=8)  :: date
        character(len=10) :: time
        character(len=5)  :: zone

        ! write (*, '(a, es24.16e3)') 'full precision', flt

        call date_and_time(date, time, zone)
        write (*, '(*(a))') 'Running on ', date(1:4), '-', date(5:6), '-', &
            date(7:8), ' at ', time(1:2), ':', time(3:4), ':', time(5:6),  &
            ':', ' in ', zone

        write (*, '(2a)') 'Compiler: ', compiler_version()
        write (*, '(2a)') 'Flags: ', compiler_options()

#ifdef DEB
        write(*,*) 'compiled in debug mode'
#endif
#ifdef OPT
        write(*,*) 'compiled in optimized mode'
#endif

        do k = 1, command_argument_count()
            call get_command_argument(k, arg)
            if (trim(arg) == '--initonly') then
                call init_test()
                stop 0
            endif
        end do
    end subroutine

    subroutine init_test()
        !!
        !! Run some basic tests and exit.
        !!
        use omp_lib, ONLY: omp_get_thread_num, omp_get_num_threads
        integer, parameter :: N = 8
        real(dp), dimension(N, N) :: D
        real(dp), dimension(N) :: ER, EI
        real(dp), dimension(6*N) :: work
        real(dp), dimension(1, 1) :: notrefd
        integer :: pid, status

!$OMP PARALLEL PRIVATE(pid)
        pid = omp_get_thread_num() + 1
        write (*, '(a,I0,a,I0)') 'hello from openmp thread ', pid, &
            ' / ', omp_get_num_threads()
!$OMP END PARALLEL

        write (*, *) 'diagonalizing laplacian with DSTEV'
        ER = 2
        EI = -1
        write(*, *) 'tmp OFF'
        status = 0
        ! call DSTEV('N', N, ER, EI, notrefd, N, work, status)
        if (status /= 0) then
            write (*, *) 'DSTEV failed, code', status
            stop 1
        end if
        write (*, *) 'DSTEV eigenvalues:'
        call print_vector(ER)
        write (*, *) 'diagonalizing laplacian with DGEEV'
        call laplacian(D, N, 2)
        do pid = 1, N
            do status = 1, N
                D(pid, status) = pid / (status + 1.0d0)
            end do
        end do
        call print_matrix(D)
        call DGEEV('N', 'N', N, D, N, ER, EI, notrefd, 1, notrefd, 1, work, 6*N, status)
        if (status /= 0) then
            write (*, *) 'DGEEV failed, code', status
            stop 1
        end if
        write (*, *) 'DGEEV eigenvalues:'
        call print_vector(ER)
        call print_vector(EI)
        write (*, *) 'exiting runtest'
    end subroutine

    subroutine laplacian(D, N, deg)
        !!
        !! Laplacian (numerical differentiation) matrix.
        !!
        integer, intent(in) :: N
        real(dp), dimension(N, N), intent(out) :: D
        integer, value, optional :: deg  !! not useful at this time
        integer :: k
        if ( .not. present(deg) ) then
            deg = 2
        end if
        if (N < 2) then
            write (*, *) 'cannot create laplacian smaller than 2x2; got', N
            stop 1
        end if
        D = 0  !! speed up?
        do k = 2, N-1
            D(k+1, k) = -1
            D(k-1, k) = -1
            D(k,   k) = deg
            ! do m = max(1, k), min(M, k)
            ! end do
        end do
        D(1, 1) = deg
        D(2, 1) = -1
        D(N, N) = deg
        D(N-1, N) = -1
    end subroutine

    subroutine print_vector(data)
        !!
        !! Print a 1D matrix to the screen.
        !!
        real(dp), intent(in), dimension(:) :: data
        integer :: k
        do k = 1, (size(data, 1) - 1)
            write(*, '(f12.6,a)', advance='no') data(k), ', '
        end do
        write(*, '(f12.6)', advance='yes') data(k)
    end subroutine

    subroutine print_matrix(data)
        !!
        !! Print a 2D matrix to the screen.
        !!
        real(dp), intent(in), dimension(:, :) :: data
        integer :: k, m

        do m = 1, size(data, 2)
            do k = 1, (size(data, 1) - 1)
                write(*, '(f12.6,a)', advance='no') data(k, m), ', '
            end do
            write(*, '(f12.6)', advance='yes') data(k, m)
        end do
    end subroutine

    !! todo: backspace (unit=unit)
    subroutine write_csv_d2(pth, data)
        !!
        !! Write a double precision 2D matrix to a csv file
        !!
        character(len=*), intent(in) :: pth
        real(dp), intent(in), dimension(:, :) :: data
        integer :: k, m, unit

        open(newunit=unit, file=pth, status="replace")
        do m = 1, size(data, 2)
            do k = 1, (size(data, 1) - 1)
                write(unit, '(es24.16e3,a)', advance='no') data(k, m), ','
            end do
            write(unit, '(es24.16e3)', advance='yes') data(k, m)
        end do
        close(unit)
    end subroutine

    subroutine write_csv_i2(pth, data)
        character(len=*), intent(in) :: pth
        integer, intent(in), dimension(:, :) :: data
        integer :: k, m, unit

        open(newunit=unit, file=pth, status="replace")
        do m = 1, size(data, 2)
            do k = 1, (size(data, 1) - 1)
                !! todo: is I0 the correct format?
                write(unit, '(I0)', advance='no') data(k, m), ','
            end do
            write(unit, '(I0)', advance='yes') data(k, m)
        end do
        close(unit)
    end subroutine

    subroutine write_csv_dd1(pth, data, data2)
        !!
        !! Write one or two columns of float data to csv file.
        !!
        character(len=*), intent(in) :: pth
        real(dp), intent(in), dimension(:) :: data
        real(dp), intent(in), dimension(size(data)), optional :: data2
        integer :: m, unit

        open(newunit=unit, file=pth, status="replace")
        if( present(data2) ) then
            do m = 1, size(data, 1)
                write(unit, '(es24.16e3,a,es24.16e3)', advance='yes') data(m), ',', data2(m)
            end do
        else
            do m = 1, size(data, 1)
                write(unit, '(es24.16e3)', advance='yes') data(m)
            end do
        end if
        close(unit)
    end subroutine

    subroutine write_csv_ii1(pth, data, data2)
        character(len=*), intent(in) :: pth
        integer, intent(in), dimension(:) :: data
        integer, intent(in), dimension(size(data)), optional :: data2
        integer :: m, unit

        open(newunit=unit, file=pth, status="replace")
        if( present(data2) ) then
            do m = 1, size(data, 1)
                write(unit, '(I0,a,I0)', advance='yes') data(m), ',', data2(m)
            end do
        else
            do m = 1, size(data, 1)
                write(unit, '(I0)', advance='yes') data(m)
            end do
        end if
        close(unit)
    end subroutine

    subroutine write_csv_id1(pth, data, data2)
        character(len=*), intent(in) :: pth
        integer, intent(in), dimension(:) :: data
        real(dp), intent(in), dimension(size(data)) :: data2
        integer :: m, unit

        open(newunit=unit, file=pth, status="replace")
        do m = 1, size(data, 1)
            write(unit, '(I0,a,es24.16e3)', advance='yes') data(m), ',', data2(m)
        end do
        close(unit)
    end subroutine
end module


