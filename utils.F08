
module my_utils
    implicit none
    private
    public dp, do_setup, write_csv

    integer, parameter:: dp=kind(0.d0)

    interface write_csv
        module procedure write_csv_d2, write_csv_i2, write_csv_dd1, write_csv_ii1, write_csv_id1
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

        ! write (*, '(a, es23.16)') 'full precision', flt

        call date_and_time(date, time, zone)
        write (*, '(*(a))') 'Running on ', date(1:4), '-', date(5:6), '-', &
            date(7:8), ' at ', time(1:2), ':', time(3:4), ':', time(5:6),  &
            ':', ' in ', zone

        write (*, '(2a)') 'Compiler: ', compiler_version()
        write (*, '(2a)') 'Flags: ', compiler_options()

#ifdef DEB
        write(*,*) 'compiled in debug mode'
#else
#ifdef OPT
        write(*,*) 'compiled in optimized mode'
#endif
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
        integer :: pid
!$OMP PARALLEL PRIVATE(pid)
        pid = omp_get_thread_num() + 1
        write (*, '(a,I0,a,I0)') 'hello from openmp thread ', pid, &
            ' / ', omp_get_num_threads()
!$OMP END PARALLEL
        write (*, *) 'exiting runtest'
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
                write(unit, '(es23.16,a)', advance='no') data(k, m), ','
            end do
            write(unit, '(es23.16)', advance='yes') data(k, m)
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
                write(unit, '(es23.16,a,es23.16)', advance='yes') data(m), ',', data2(m)
            end do
        else
            do m = 1, size(data, 1)
                write(unit, '(es23.16)', advance='yes') data(m)
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
            write(unit, '(I0,a,es23.16)', advance='yes') data(m), ',', data2(m)
        end do
        close(unit)
    end subroutine
end module


