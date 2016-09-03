
module my_debug
    use my_utils, only: dp, print_matrix
    implicit none

    private
    public bound_checks, aliasing

    contains

    subroutine aliasing()
        !!
        !! Test aliasing (no pointers needed).
        !!
        real(dp), dimension(3, 3) :: mat
        real(dp) :: in, out
        mat = 0
        call alias_vecs(mat(1, :), mat(:, 1))
        call print_matrix(mat)
        in = 2
        call alias_pythago(x=in, y=in, z=out)
        write(*, *) 'in', in, 'out', out
    end subroutine aliasing

    subroutine alias_vecs(vec1, vec2)
        !!
        !! This assigns values to two vectors, which may overlap, which is aliasing.
        !! But I don't know how to get the compiler to change the order (which is may do
        !! as an optimization) to show the effect...
        !!
        real(dp), dimension(:), intent(out) :: vec1, vec2
        vec1 = 5
        vec2 = 42
    end subroutine alias_vecs

    subroutine alias_pythago(x, y, z)
        !!
        !!
        !!
        real(dp), intent(inout) :: x, y
        real(dp), intent(out) :: z
        x = 1
        z = (x**2 + y**2)**0.5d0
    end subroutine alias_pythago

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
        ! call bound_check_sub(150, arr, 170)  ! this throws a runtime error
        ! call type_corruption(150, arr, 170)  ! this IS detected (at compile time)
    end subroutine bound_checks

    subroutine bound_check_sub(n, D, q)
        !!
        !! Check whether bound checks can cross subroutine boundaries.
        !!
        integer :: n, q
        real(kind=dp), dimension(n) :: D
        write(*, *) D(q)
    end subroutine bound_check_sub

    subroutine type_corruption(n, D, q)
        !!
        !! Check whether type checks can cross subroutine boundaries.
        !!
        integer :: n, q
        integer, dimension(n) :: D
        write(*, *) D(q)
    end subroutine type_corruption

end module my_debug


