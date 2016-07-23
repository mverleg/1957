
module indx_spd_test
    use blas, only: DGEMV
    use my_utils, only: dp, print_matrix

    implicit none
    private
    public test_speed

    contains

    subroutine test_speed()
        integer, parameter :: p = 10, q = 15
        real(dp), dimension(p, q) :: M
        real(dp), dimension(p) :: v
        real(dp), dimension(q) :: w
        real(dp) :: tstart, tfinish

        call init_Mvw(M, v, w)
        call print_matrix(M)

        call init_Mvw(M, v, w)
        write(*, '(1x,a/)') 'mat_mult_outer'
        call cpu_time(tstart)
        call mat_mult_outer(M, v, w)
        call cpu_time(tfinish)
        write(*, '(1x,f10.6,a)') tfinish - tstart, 's'

        call init_Mvw(M, v, w)
        write(*, '(1x,a/)') 'mat_mult_inner '
        call cpu_time(tstart)
        call mat_mult_inner(M, v, w)
        call cpu_time(tfinish)
        write(*, '(1x,f10.6,a)') tfinish - tstart, 's'

        call init_Mvw(M, v, w)
        write(*, '(1x,a/)') 'blas dgemv    '
        call cpu_time(tstart)
        call DGEMV('N', p, w, 1, M, p, v, 1, 0, w, 1)
        call cpu_time(tfinish)
        write(*, '(1x,f10.6,a)') tfinish - tstart, 's'
    end subroutine

    subroutine init_Mvw(M, v, w)
        real(dp), dimension(:, :), intent(out) :: M
        real(dp), dimension(:), intent(out) :: v, w
        integer :: j, k, p, q

        p = size(M, 1)
        q = size(M, 2)
        M = 0
        do j = 1, p
            do k = 1, q
                if (j >= k) then
                    M(k, j) = 1
                end if
            end do
        end do
        v = 1
        w = 999999
    end subroutine

    subroutine mat_mult_inner(M, v, w)
        real(dp), dimension(:, :), intent(in) :: M
        real(dp), dimension(:), intent(in) :: v
        real(dp), dimension(:), intent(out) :: w
        integer :: j, k, p, q

        p = size(M, 1)
        q = size(M, 2)
        do j = 1, p
            do k = 1, q
                w(j) = M(j, k) * v(k)
            end do
        end do
    end subroutine
end module


