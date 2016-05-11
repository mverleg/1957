

module mteop
    use my_utils, only: dp

    implicit none
    private
    public cube, dcube, icube, dcubef

    interface cube
        module procedure dcube, icube
    end interface

    contains

    elemental subroutine dcube(x)
        real(dp), intent(inout) :: x
        x = x**3
    end subroutine

    elemental subroutine icube(x)
        integer, intent(inout) :: x
        x = x**3
    end subroutine

    function dcubef(x) result(y)
        real(dp), intent(in), dimension(:, :), contiguous :: x
        real(dp), dimension(size(x, 1), size(x, 2)) :: y
        y = x**3
    end function

end module




!! 1D
! subroutine f(r)
! real(dp), intent(in) :: r(:)
! integer :: n, i
! n = size(r)
! do i = 1, n
!     r(i) = 1.0_dp / i**2
! enddo
! end subroutine

!! 2D
! subroutine g(A)
! real(dp), intent(in) :: A(:, :)
! ...
! end subroutine

! write (*, '(a, es24.16e3)') 'full precision', flt

