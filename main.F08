
program demo
    use my_utils, only: dp, do_setup, write_csv
    use mteop, only: cube, dcubef

    real(kind=dp), dimension(10, 8) :: x
    integer, dimension(500) :: y
    y = 16
    x = 2  ! don't initialize in declaration, or 'save' is implied

    call do_setup()

    call cube(y)
    x = dcubef(x)

    call write_csv("cube2d.csv", x)
    call write_csv("cube1i.csv", y, y)

end program


