1957
===============================

Random Fortran stuff.

Blas/Lapack interface
-------------------------------

If you want explicit interfaces for blas/lapack, you can use `blas.f90`_ and `lapack.f90`_. These files have been extracted from the blas and lapack Fortran reference source using the included interfacify_fortran.py script (which works well except for multiple subroutines per file, which is very rare for blas/lapack). The purpose is to be able to do ``use lapack, only: DGEEV, DSTEV`` and compile with ``-Wimplicit-procedure`` to check that routines exist and have correct arguments.

Lanczos algorithm
-------------------------------

Includes a simple implementation of Lanczos algorithm (compile with ``scons lanczos``) to estimate the extreme eigenvalue of a Hermitian matrix. There are much more advanced implementations online, but this one is elegant and easy. A test, which functions as a demo, is included.

Requires
-------------------------------

* SCons_ for building (info_)
* Blas and LAPACK
* `AMD openCL SDK`_ or equivalent depending on your CPU/GPU
* FortranCL_
* coarrays: no longer used


.. _blas.f90: https://github.com/mverleg/1957/blob/master/lib/blas.f90
.. _lapack.f90: https://github.com/mverleg/1957/blob/master/lib/lapack.f90
.. _SCons: http://scons.org/
.. _`AMD openCL SDK`: http://developer.amd.com/tools-and-sdks/opencl-zone/amd-accelerated-parallel-processing-app-sdk/
.. _FortrancL: https://github.com/Devac/fortrancl/blob/master/INSTALL
.. _info: https://bitbucket.org/scons/scons/wiki/MultipleDirectoryFortranBuild


