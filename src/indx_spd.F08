
module indx_spd_test
    ! use blas, only: DGEMV
    ! use my_utils, only: dp, print_matrix

    implicit none
    private
    public test_speed

    integer, parameter:: dp=kind(0.d0)

    contains

    subroutine test_speed()
        integer, parameter :: p = 1000, q = 1000, N = 1000
        integer :: r, z, z1, z2
        real(dp), dimension(p, q) :: M
        real(dp), dimension(q) :: v
        real(dp), dimension(p) :: w
        real(dp) :: tstart, tfinish, outert, innert, blast

        z1 = 0
        z2 = 0
        call init_Mvw(M, v, w)
        ! call print_matrix(M)

        call init_Mvw(M, v, w)
        write(*, '(1x,a)', advance='no') 'mat_mult_outer'
        call cpu_time(tstart)
        do r = 1, N
            call mat_mult_outer(M, v, w, z)
            z1 = z1 + z
        end do
        call cpu_time(tfinish)
        outert = tfinish - tstart
        write(*, '(1x,f10.6,a)') outert, 's'

        call init_Mvw(M, v, w)
        write(*, '(1x,a)', advance='no') 'mat_mult_inner'
        call cpu_time(tstart)
        do r = 1, N
            call mat_mult_inner(M, v, w, z)
            z2 = z2 + z
        end do
        call cpu_time(tfinish)
        innert = tfinish - tstart
        write(*, '(1x,f10.6,a)') innert, 's'

        if (z1 /= z2) then
            write(*, *) 'inner and outer loop differ:', z1, z2
            stop 1
        end if

        call init_Mvw(M, v, w)
        write(*, '(1x,a)', advance='no') 'blas dgemv    '
        call cpu_time(tstart)
        do r = 1, N
            call DGEMV('N', p, q, 1.d0, M, p, v, 1, 0.d0, w, 1)
        end do
        call cpu_time(tfinish)
        blast = tfinish - tstart
        write(*, '(1x,f10.6,a)') blast, 's'

        write(*, '(1x,a,1x,f10.6,1x,f10.6,1x,f10.6)') 'time ratios: ', &
            outert / innert, innert / innert, blast / innert
    end subroutine

    subroutine init_Mvw(M, v, w)
        real(dp), dimension(:, :), intent(out) :: M
        real(dp), dimension(:), intent(out) :: v, w
        ! integer :: j, k, p, q

        !p = size(M, 1)
        !q = size(M, 2)
        !M = 0
        !do k = 1, q
        !    do j = 1, p
        !        if (j >= k) then
        !            M(j, k) = 1
        !        end if
        !    end do
        !end do
        !v = 1
        call random_number(M)
        call random_number(v)
        w = 999999
    end subroutine

    subroutine mat_mult_inner(M, v, w, z)
        real(dp), dimension(:, :), intent(in) :: M
        real(dp), dimension(:), intent(in) :: v
        real(dp), dimension(:), intent(out) :: w
        integer :: j, k, p, q
        integer, intent(out) :: z

        p = size(M, 1)
        q = size(M, 2)
        w = 0
        z = 0
        do k = 1, q
            do j = 1, p
                w(j) = w(j) + M(j, k) * v(k)
            end do
            z = z + k  !! prevent swapping loop levels
        end do
    end subroutine

    subroutine mat_mult_outer(M, v, w, z)
        real(dp), dimension(:, :), intent(in) :: M
        real(dp), dimension(:), intent(in) :: v
        real(dp), dimension(:), intent(out) :: w
        integer :: j, k, p, q
        integer, intent(out) :: z

        p = size(M, 1)
        q = size(M, 2)
        w = 0
        z = 0
        do j = 1, p
            do k = 1, q
                w(j) = w(j) + M(j, k) * v(k)
            end do
            z = z + j  !! prevent swapping loop levels
        end do
    end subroutine
end module

!program main
!    use indx_spd_test, only: test_speed
!
!    call test_speed()
!end program main


