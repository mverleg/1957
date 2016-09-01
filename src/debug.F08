
module my_debug
    use my_utils, only: dp
    implicit none

    private
    public bound_checks

    contains

    subroutine bound_checks()
        !!
        !! Check whether bound checks work and whether bound checks in submodules work.
        !!
        real(kind=dp), dimension(10, 10) :: arr
        integer :: q
        q = 12
        arr = 42
        ! write(*, *) arr(10, q)               ! this throws a RUN-time error
        call bound_check_sub(100, arr, 15)     ! this passes, as it should
        ! call bound_check_sub(100, arr, 110)  ! this does throw a run-time error
        ! call bound_check_sub(50, arr, 70)    ! throws runtime error (reasonable but informative)
        call bound_check_sub(150, arr, 120)    ! this does NOT throw any error!
        call bound_check_sub(150, arr, 170)    ! this throws a runtime error
    end subroutine bound_checks

    subroutine bound_check_sub(n, D, q)
        !!
        !! Check whether bound checks can cross subroutine boundaries.
        !!
        integer :: n, q
        real(kind=dp), dimension(n) :: D
        write(*, *) D(q)
    end subroutine bound_check_sub

end module my_debug


