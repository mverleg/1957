
module indx_spd_test
    use blas, only: DGEMV
    use my_utils, only: dp, print_matrix

    implicit none
    private
    public test_speed

    contains

    subroutine test_speed()
        integer, parameter :: p = 1000, q = 1000, N = 500
        integer :: r
        real(dp), dimension(p, q) :: M
        real(dp), dimension(q) :: v
        real(dp), dimension(p) :: w
        real(dp) :: tstart, tfinish

        call init_Mvw(M, v, w)
        ! call print_matrix(M)

        call init_Mvw(M, v, w)
        write(*, '(1x,a)', advance='no') 'mat_mult_outer'
        call cpu_time(tstart)
        do r = 1, N
            call mat_mult_outer(M, v, w)
        end do
        call cpu_time(tfinish)
        write(*, '(1x,f10.6,a)') tfinish - tstart, 's'

        call init_Mvw(M, v, w)
        write(*, '(1x,a)', advance='no') 'mat_mult_inner'
        call cpu_time(tstart)
        do r = 1, N
            call mat_mult_inner(M, v, w)
        end do
        call cpu_time(tfinish)
        write(*, '(1x,f10.6,a)') tfinish - tstart, 's'

        call init_Mvw(M, v, w)
        write(*, '(1x,a)', advance='no') 'blas dgemv    '
        call cpu_time(tstart)
        do r = 1, N
            call DGEMV('N', p, q, 1.d0, M, p, v, 1, 0.d0, w, 1)
        end do
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
        do k = 1, q
            do j = 1, p
                if (j >= k) then
                    M(j, k) = 1
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
        ! write(*, *) shape(M)
        w = 0
        do k = 1, q
            do j = 1, p
                w(j) = w(j) + M(j, k) * v(k)
            end do
        end do
    end subroutine

    subroutine mat_mult_outer(M, v, w)
        real(dp), dimension(:, :), intent(in) :: M
        real(dp), dimension(:), intent(in) :: v
        real(dp), dimension(:), intent(out) :: w
        integer :: j, k, p, q

        p = size(M, 1)
        q = size(M, 2)
        ! write(*, *) shape(M)
        w = 0
        do j = 1, p
            do k = 1, q
                w(j) = w(j) + M(j, k) * v(k)
            end do
        end do
    end subroutine
end module


