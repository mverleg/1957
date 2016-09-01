
program demo
    use my_utils, only: dp, do_setup, write_csv
    use mteop, only: cube, dcubef
    use indx_spd_test, only: test_speed
    use my_debug, only: bound_checks

    real(dp), dimension(10, 8) :: x
    integer, dimension(500) :: y
    integer, dimension(32) :: z
    integer :: k
    y = 16
    x = 2  ! don't initialize in declaration, or 'save' is implied

    call do_setup()

    ! call test_speed()

    forall (k = 1:size(z))
        z(k) = k
    end forall
    where (modulo(z, 2) == 0) z = (-1*z)

    call cube(y)
    x = dcubef(x)

    call write_csv("cube2d.csv", x)
    call write_csv("cube1i.csv", y, y)

    call bound_checks()

end program


