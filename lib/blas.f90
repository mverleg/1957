      !! automatically generated interface
      !! pipe a .f90 file & compile with -ffixed-form

      module blas

      public

      interface

      !! caxpy.f
      subroutine caxpy(n,ca,cx,incx,cy,incy)
      complex ca
      integer incx,incy,n
      complex cx(*),cy(*)
      integer i,ix,iy
      real scabs1
      end subroutine caxpy

      !! ccopy.f
      subroutine ccopy(n,cx,incx,cy,incy)
      integer incx,incy,n
      complex cx(*),cy(*)
      integer i,ix,iy
      end subroutine ccopy

      !! cdotc.f
      complex function cdotc(n,cx,incx,cy,incy)
      integer incx,incy,n
      complex cx(*),cy(*)
      complex ctemp
      integer i,ix,iy
      end function cdotc

      !! cdotu.f
      complex function cdotu(n,cx,incx,cy,incy)
      integer incx,incy,n
      complex cx(*),cy(*)
      complex ctemp
      integer i,ix,iy
      end function cdotu

      !! cgbmv.f
      subroutine cgbmv(trans,m,n,kl,ku,alpha,a,lda,x,incx,beta,y,incy)
      complex alpha,beta
      integer incx,incy,kl,ku,lda,m,n
      character trans
      complex a(lda,*),x(*),y(*)
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,iy,j,jx,jy,k,kup1,kx,ky,lenx,leny
      logical noconj
      logical lsame
      end subroutine cgbmv

      !! cgemm.f
      subroutine cgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      complex alpha,beta
      integer k,lda,ldb,ldc,m,n
      character transa,transb
      complex a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex temp
      integer i,info,j,l,ncola,nrowa,nrowb
      logical conja,conjb,nota,notb
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine cgemm

      !! cgemv.f
      subroutine cgemv(trans,m,n,alpha,a,lda,x,incx,beta,y,incy)
      complex alpha,beta
      integer incx,incy,lda,m,n
      character trans
      complex a(lda,*),x(*),y(*)
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,iy,j,jx,jy,kx,ky,lenx,leny
      logical noconj
      logical lsame
      end subroutine cgemv

      !! cgerc.f
      subroutine cgerc(m,n,alpha,x,incx,y,incy,a,lda)
      complex alpha
      integer incx,incy,lda,m,n
      complex a(lda,*),x(*),y(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jy,kx
      end subroutine cgerc

      !! cgeru.f
      subroutine cgeru(m,n,alpha,x,incx,y,incy,a,lda)
      complex alpha
      integer incx,incy,lda,m,n
      complex a(lda,*),x(*),y(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jy,kx
      end subroutine cgeru

      !! chbmv.f
      subroutine chbmv(uplo,n,k,alpha,a,lda,x,incx,beta,y,incy)
      complex alpha,beta
      integer incx,incy,k,lda,n
      character uplo
      complex a(lda,*),x(*),y(*)
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kplus1,kx,ky,l
      logical lsame
      end subroutine chbmv

      !! chemm.f
      subroutine chemm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
      complex alpha,beta
      integer lda,ldb,ldc,m,n
      character side,uplo
      complex a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex temp1,temp2
      integer i,info,j,k,nrowa
      logical upper
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine chemm

      !! chemv.f
      subroutine chemv(uplo,n,alpha,a,lda,x,incx,beta,y,incy)
      complex alpha,beta
      integer incx,incy,lda,n
      character uplo
      complex a(lda,*),x(*),y(*)
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine chemv

      !! cher2.f
      subroutine cher2(uplo,n,alpha,x,incx,y,incy,a,lda)
      complex alpha
      integer incx,incy,lda,n
      character uplo
      complex a(lda,*),x(*),y(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine cher2

      !! cher2k.f
      subroutine cher2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      complex alpha
      real beta
      integer k,lda,ldb,ldc,n
      character trans,uplo
      complex a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex temp1,temp2
      integer i,info,j,l,nrowa
      logical upper
      real one
      parameter (one=1.0e+0)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine cher2k

      !! cher.f
      subroutine cher(uplo,n,alpha,x,incx,a,lda)
      real alpha
      integer incx,lda,n
      character uplo
      complex a(lda,*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,kx
      logical lsame
      end subroutine cher

      !! cherk.f
      subroutine cherk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
      real alpha,beta
      integer k,lda,ldc,n
      character trans,uplo
      complex a(lda,*),c(ldc,*)
      logical lsame
      complex temp
      real rtemp
      integer i,info,j,l,nrowa
      logical upper
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine cherk

      !! chpmv.f
      subroutine chpmv(uplo,n,alpha,ap,x,incx,beta,y,incy)
      complex alpha,beta
      integer incx,incy,n
      character uplo
      complex ap(*),x(*),y(*)
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine chpmv

      !! chpr2.f
      subroutine chpr2(uplo,n,alpha,x,incx,y,incy,ap)
      complex alpha
      integer incx,incy,n
      character uplo
      complex ap(*),x(*),y(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine chpr2

      !! chpr.f
      subroutine chpr(uplo,n,alpha,x,incx,ap)
      real alpha
      integer incx,n
      character uplo
      complex ap(*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,k,kk,kx
      logical lsame
      end subroutine chpr

      !! crotg.f
      subroutine crotg(ca,cb,c,s)
      complex ca,cb,s
      real c
      complex alpha
      real norm,scale
      end subroutine crotg

      !! cscal.f
      subroutine cscal(n,ca,cx,incx)
      complex ca
      integer incx,n
      complex cx(*)
      integer i,nincx
      end subroutine cscal

      !! csrot.f
      subroutine csrot( n, cx, incx, cy, incy, c, s )
      integer           incx, incy, n
      real              c, s
      complex           cx( * ), cy( * )
      integer           i, ix, iy
      complex           ctemp
      end subroutine csrot

      !! csscal.f
      subroutine csscal(n,sa,cx,incx)
      real sa
      integer incx,n
      complex cx(*)
      integer i,nincx
      end subroutine csscal

      !! cswap.f
      subroutine cswap(n,cx,incx,cy,incy)
      integer incx,incy,n
      complex cx(*),cy(*)
      complex ctemp
      integer i,ix,iy
      end subroutine cswap

      !! csymm.f
      subroutine csymm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
      complex alpha,beta
      integer lda,ldb,ldc,m,n
      character side,uplo
      complex a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex temp1,temp2
      integer i,info,j,k,nrowa
      logical upper
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine csymm

      !! csyr2k.f
      subroutine csyr2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      complex alpha,beta
      integer k,lda,ldb,ldc,n
      character trans,uplo
      complex a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex temp1,temp2
      integer i,info,j,l,nrowa
      logical upper
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine csyr2k

      !! csyrk.f
      subroutine csyrk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
      complex alpha,beta
      integer k,lda,ldc,n
      character trans,uplo
      complex a(lda,*),c(ldc,*)
      logical lsame
      complex temp
      integer i,info,j,l,nrowa
      logical upper
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine csyrk

      !! ctbmv.f
      subroutine ctbmv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      complex a(lda,*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical noconj,nounit
      logical lsame
      end subroutine ctbmv

      !! ctbsv.f
      subroutine ctbsv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      complex a(lda,*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical noconj,nounit
      logical lsame
      end subroutine ctbsv

      !! ctpmv.f
      subroutine ctpmv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      complex ap(*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,k,kk,kx
      logical noconj,nounit
      logical lsame
      end subroutine ctpmv

      !! ctpsv.f
      subroutine ctpsv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      complex ap(*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,k,kk,kx
      logical noconj,nounit
      logical lsame
      end subroutine ctpsv

      !! ctrmm.f
      subroutine ctrmm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      complex alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      complex a(lda,*),b(ldb,*)
      logical lsame
      complex temp
      integer i,info,j,k,nrowa
      logical lside,noconj,nounit,upper
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine ctrmm

      !! ctrmv.f
      subroutine ctrmv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      complex a(lda,*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,kx
      logical noconj,nounit
      logical lsame
      end subroutine ctrmv

      !! ctrsm.f
      subroutine ctrsm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      complex alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      complex a(lda,*),b(ldb,*)
      logical lsame
      complex temp
      integer i,info,j,k,nrowa
      logical lside,noconj,nounit,upper
      complex one
      parameter (one= (1.0e+0,0.0e+0))
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      end subroutine ctrsm

      !! ctrsv.f
      subroutine ctrsv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      complex a(lda,*),x(*)
      complex zero
      parameter (zero= (0.0e+0,0.0e+0))
      complex temp
      integer i,info,ix,j,jx,kx
      logical noconj,nounit
      logical lsame
      end subroutine ctrsv

      !! dasum.f
      double precision function dasum(n,dx,incx)
      integer incx,n
      double precision dx(*)
      double precision dtemp
      integer i,m,mp1,nincx
      end function dasum

      !! daxpy.f
      subroutine daxpy(n,da,dx,incx,dy,incy)
      double precision da
      integer incx,incy,n
      double precision dx(*),dy(*)
      integer i,ix,iy,m,mp1
      end subroutine daxpy

      !! dcabs1.f
      double precision function dcabs1(z)
      complex(kind=8)  z
      end function dcabs1

      !! dcopy.f
      subroutine dcopy(n,dx,incx,dy,incy)
      integer incx,incy,n
      double precision dx(*),dy(*)
      integer i,ix,iy,m,mp1
      end subroutine dcopy

      !! ddot.f
      double precision function ddot(n,dx,incx,dy,incy)
      integer incx,incy,n
      double precision dx(*),dy(*)
      double precision dtemp
      integer i,ix,iy,m,mp1
      end function ddot

      !! dgbmv.f
      subroutine dgbmv(trans,m,n,kl,ku,alpha,a,lda,x,incx,beta,y,incy)
      double precision alpha,beta
      integer incx,incy,kl,ku,lda,m,n
      character trans
      double precision a(lda,*),x(*),y(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision temp
      integer i,info,ix,iy,j,jx,jy,k,kup1,kx,ky,lenx,leny
      logical lsame
      end subroutine dgbmv

      !! dgemm.f
      subroutine dgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      double precision alpha,beta
      integer k,lda,ldb,ldc,m,n
      character transa,transb
      double precision a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      double precision temp
      integer i,info,j,l,ncola,nrowa,nrowb
      logical nota,notb
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine dgemm

      !! dgemv.f
      subroutine dgemv(trans,m,n,alpha,a,lda,x,incx,beta,y,incy)
      double precision alpha,beta
      integer incx,incy,lda,m,n
      character trans
      double precision a(lda,*),x(*),y(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision temp
      integer i,info,ix,iy,j,jx,jy,kx,ky,lenx,leny
      logical lsame
      end subroutine dgemv

      !! dger.f
      subroutine dger(m,n,alpha,x,incx,y,incy,a,lda)
      double precision alpha
      integer incx,incy,lda,m,n
      double precision a(lda,*),x(*),y(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jy,kx
      end subroutine dger

      !! dnrm2.f
      double precision function dnrm2(n,x,incx)
      integer incx,n
      double precision x(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision absxi,norm,scale,ssq
      integer ix
      end function dnrm2

      !! drot.f
      subroutine drot(n,dx,incx,dy,incy,c,s)
      double precision c,s
      integer incx,incy,n
      double precision dx(*),dy(*)
      double precision dtemp
      integer i,ix,iy
      end subroutine drot

      !! drotg.f
      subroutine drotg(da,db,c,s)
      double precision c,da,db,s
      double precision r,roe,scale,z
      end subroutine drotg

      !! drotm.f
      subroutine drotm(n,dx,incx,dy,incy,dparam)
      integer incx,incy,n
      double precision dparam(5),dx(*),dy(*)
      double precision dflag,dh11,dh12,dh21,dh22,two,w,z,zero
      integer i,kx,ky,nsteps
      end subroutine drotm

      !! drotmg.f
      subroutine drotmg(dd1,dd2,dx1,dy1,dparam)
      double precision dd1,dd2,dx1,dy1
      double precision dparam(5)
      double precision dflag,dh11,dh12,dh21,dh22,dp1,dp2,dq1,dq2,dtemp,
     &                 du,gam,gamsq,one,rgamsq,two,zero
      end subroutine drotmg

      !! dsbmv.f
      subroutine dsbmv(uplo,n,k,alpha,a,lda,x,incx,beta,y,incy)
      double precision alpha,beta
      integer incx,incy,k,lda,n
      character uplo
      double precision a(lda,*),x(*),y(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kplus1,kx,ky,l
      logical lsame
      end subroutine dsbmv

      !! dscal.f
      subroutine dscal(n,da,dx,incx)
      double precision da
      integer incx,n
      double precision dx(*)
      integer i,m,mp1,nincx
      end subroutine dscal

      !! dsdot.f
      double precision function dsdot(n,sx,incx,sy,incy)
      integer incx,incy,n
      real sx(*),sy(*)
      integer i,kx,ky,ns
      end function dsdot

      !! dspmv.f
      subroutine dspmv(uplo,n,alpha,ap,x,incx,beta,y,incy)
      double precision alpha,beta
      integer incx,incy,n
      character uplo
      double precision ap(*),x(*),y(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine dspmv

      !! dspr2.f
      subroutine dspr2(uplo,n,alpha,x,incx,y,incy,ap)
      double precision alpha
      integer incx,incy,n
      character uplo
      double precision ap(*),x(*),y(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine dspr2

      !! dspr.f
      subroutine dspr(uplo,n,alpha,x,incx,ap)
      double precision alpha
      integer incx,n
      character uplo
      double precision ap(*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,k,kk,kx
      logical lsame
      end subroutine dspr

      !! dswap.f
      subroutine dswap(n,dx,incx,dy,incy)
      integer incx,incy,n
      double precision dx(*),dy(*)
      double precision dtemp
      integer i,ix,iy,m,mp1
      end subroutine dswap

      !! dsymm.f
      subroutine dsymm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
      double precision alpha,beta
      integer lda,ldb,ldc,m,n
      character side,uplo
      double precision a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      double precision temp1,temp2
      integer i,info,j,k,nrowa
      logical upper
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine dsymm

      !! dsymv.f
      subroutine dsymv(uplo,n,alpha,a,lda,x,incx,beta,y,incy)
      double precision alpha,beta
      integer incx,incy,lda,n
      character uplo
      double precision a(lda,*),x(*),y(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine dsymv

      !! dsyr2.f
      subroutine dsyr2(uplo,n,alpha,x,incx,y,incy,a,lda)
      double precision alpha
      integer incx,incy,lda,n
      character uplo
      double precision a(lda,*),x(*),y(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine dsyr2

      !! dsyr2k.f
      subroutine dsyr2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      double precision alpha,beta
      integer k,lda,ldb,ldc,n
      character trans,uplo
      double precision a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      double precision temp1,temp2
      integer i,info,j,l,nrowa
      logical upper
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine dsyr2k

      !! dsyr.f
      subroutine dsyr(uplo,n,alpha,x,incx,a,lda)
      double precision alpha
      integer incx,lda,n
      character uplo
      double precision a(lda,*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,kx
      logical lsame
      end subroutine dsyr

      !! dsyrk.f
      subroutine dsyrk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
      double precision alpha,beta
      integer k,lda,ldc,n
      character trans,uplo
      double precision a(lda,*),c(ldc,*)
      logical lsame
      double precision temp
      integer i,info,j,l,nrowa
      logical upper
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine dsyrk

      !! dtbmv.f
      subroutine dtbmv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      double precision a(lda,*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical nounit
      logical lsame
      end subroutine dtbmv

      !! dtbsv.f
      subroutine dtbsv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      double precision a(lda,*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical nounit
      logical lsame
      end subroutine dtbsv

      !! dtpmv.f
      subroutine dtpmv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      double precision ap(*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,k,kk,kx
      logical nounit
      logical lsame
      end subroutine dtpmv

      !! dtpsv.f
      subroutine dtpsv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      double precision ap(*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,k,kk,kx
      logical nounit
      logical lsame
      end subroutine dtpsv

      !! dtrmm.f
      subroutine dtrmm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      double precision alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      double precision a(lda,*),b(ldb,*)
      logical lsame
      double precision temp
      integer i,info,j,k,nrowa
      logical lside,nounit,upper
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine dtrmm

      !! dtrmv.f
      subroutine dtrmv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      double precision a(lda,*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,kx
      logical nounit
      logical lsame
      end subroutine dtrmv

      !! dtrsm.f
      subroutine dtrsm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      double precision alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      double precision a(lda,*),b(ldb,*)
      logical lsame
      double precision temp
      integer i,info,j,k,nrowa
      logical lside,nounit,upper
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine dtrsm

      !! dtrsv.f
      subroutine dtrsv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      double precision a(lda,*),x(*)
      double precision zero
      parameter (zero=0.0d+0)
      double precision temp
      integer i,info,ix,j,jx,kx
      logical nounit
      logical lsame
      end subroutine dtrsv

      !! dzasum.f
      double precision function dzasum(n,zx,incx)
      integer incx,n
      complex(kind=8)  zx(*)
      double precision stemp
      integer i,nincx
      double precision dcabs1
      end function dzasum

      !! dznrm2.f
      double precision function dznrm2(n,x,incx)
      integer incx,n
      complex(kind=8)  x(*)
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      double precision norm,scale,ssq,temp
      integer ix
      end function dznrm2

      !! icamax.f
      integer function icamax(n,cx,incx)
      integer incx,n
      complex cx(*)
      real smax
      integer i,ix
      real scabs1
      end function icamax

      !! idamax.f
      integer function idamax(n,dx,incx)
      integer incx,n
      double precision dx(*)
      double precision dmax
      integer i,ix
      end function idamax

      !! isamax.f
      integer function isamax(n,sx,incx)
      integer incx,n
      real sx(*)
      real smax
      integer i,ix
      end function isamax

      !! izamax.f
      integer function izamax(n,zx,incx)
      integer incx,n
      complex(kind=8)  zx(*)
      double precision dmax
      integer i,ix
      double precision dcabs1
      end function izamax

      !! lsame.f
      logical function lsame(ca,cb)
      character ca,cb
      integer inta,intb,zcode
      end function lsame

      !! sasum.f
      real function sasum(n,sx,incx)
      integer incx,n
      real sx(*)
      real stemp
      integer i,m,mp1,nincx
      end function sasum

      !! saxpy.f
      subroutine saxpy(n,sa,sx,incx,sy,incy)
      real sa
      integer incx,incy,n
      real sx(*),sy(*)
      integer i,ix,iy,m,mp1
      end subroutine saxpy

      !! scabs1.f
      real function scabs1(z)
      complex z
      end function scabs1

      !! scasum.f
      real function scasum(n,cx,incx)
      integer incx,n
      complex cx(*)
      real stemp
      integer i,nincx
      end function scasum

      !! scnrm2.f
      real function scnrm2(n,x,incx)
      integer incx,n
      complex x(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real norm,scale,ssq,temp
      integer ix
      end function scnrm2

      !! scopy.f
      subroutine scopy(n,sx,incx,sy,incy)
      integer incx,incy,n
      real sx(*),sy(*)
      integer i,ix,iy,m,mp1
      end subroutine scopy

      !! sdot.f
      real function sdot(n,sx,incx,sy,incy)
      integer incx,incy,n
      real sx(*),sy(*)
      real stemp
      integer i,ix,iy,m,mp1
      end function sdot

      !! sdsdot.f
      real function sdsdot(n,sb,sx,incx,sy,incy)
      real sb
      integer incx,incy,n
      real sx(*),sy(*)
      double precision dsdot
      integer i,kx,ky,ns
      end function sdsdot

      !! sgbmv.f
      subroutine sgbmv(trans,m,n,kl,ku,alpha,a,lda,x,incx,beta,y,incy)
      real alpha,beta
      integer incx,incy,kl,ku,lda,m,n
      character trans
      real a(lda,*),x(*),y(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real temp
      integer i,info,ix,iy,j,jx,jy,k,kup1,kx,ky,lenx,leny
      logical lsame
      end subroutine sgbmv

      !! sgemm.f
      subroutine sgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      real alpha,beta
      integer k,lda,ldb,ldc,m,n
      character transa,transb
      real a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      real temp
      integer i,info,j,l,ncola,nrowa,nrowb
      logical nota,notb
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine sgemm

      !! sgemv.f
      subroutine sgemv(trans,m,n,alpha,a,lda,x,incx,beta,y,incy)
      real alpha,beta
      integer incx,incy,lda,m,n
      character trans
      real a(lda,*),x(*),y(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real temp
      integer i,info,ix,iy,j,jx,jy,kx,ky,lenx,leny
      logical lsame
      end subroutine sgemv

      !! sger.f
      subroutine sger(m,n,alpha,x,incx,y,incy,a,lda)
      real alpha
      integer incx,incy,lda,m,n
      real a(lda,*),x(*),y(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jy,kx
      end subroutine sger

      !! snrm2.f
      real function snrm2(n,x,incx)
      integer incx,n
      real x(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real absxi,norm,scale,ssq
      integer ix
      end function snrm2

      !! srot.f
      subroutine srot(n,sx,incx,sy,incy,c,s)
      real c,s
      integer incx,incy,n
      real sx(*),sy(*)
      real stemp
      integer i,ix,iy
      end subroutine srot

      !! srotg.f
      subroutine srotg(sa,sb,c,s)
      real c,s,sa,sb
      real r,roe,scale,z
      end subroutine srotg

      !! srotm.f
      subroutine srotm(n,sx,incx,sy,incy,sparam)
      integer incx,incy,n
      real sparam(5),sx(*),sy(*)
      real sflag,sh11,sh12,sh21,sh22,two,w,z,zero
      integer i,kx,ky,nsteps
      end subroutine srotm

      !! srotmg.f
      subroutine srotmg(sd1,sd2,sx1,sy1,sparam)
      real sd1,sd2,sx1,sy1
      real sparam(5)
      real gam,gamsq,one,rgamsq,sflag,sh11,sh12,sh21,sh22,sp1,sp2,sq1,
     &     sq2,stemp,su,two,zero
      end subroutine srotmg

      !! ssbmv.f
      subroutine ssbmv(uplo,n,k,alpha,a,lda,x,incx,beta,y,incy)
      real alpha,beta
      integer incx,incy,k,lda,n
      character uplo
      real a(lda,*),x(*),y(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kplus1,kx,ky,l
      logical lsame
      end subroutine ssbmv

      !! sscal.f
      subroutine sscal(n,sa,sx,incx)
      real sa
      integer incx,n
      real sx(*)
      integer i,m,mp1,nincx
      end subroutine sscal

      !! sspmv.f
      subroutine sspmv(uplo,n,alpha,ap,x,incx,beta,y,incy)
      real alpha,beta
      integer incx,incy,n
      character uplo
      real ap(*),x(*),y(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine sspmv

      !! sspr2.f
      subroutine sspr2(uplo,n,alpha,x,incx,y,incy,ap)
      real alpha
      integer incx,incy,n
      character uplo
      real ap(*),x(*),y(*)
      real zero
      parameter (zero=0.0e+0)
      real temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine sspr2

      !! sspr.f
      subroutine sspr(uplo,n,alpha,x,incx,ap)
      real alpha
      integer incx,n
      character uplo
      real ap(*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,k,kk,kx
      logical lsame
      end subroutine sspr

      !! sswap.f
      subroutine sswap(n,sx,incx,sy,incy)
      integer incx,incy,n
      real sx(*),sy(*)
      real stemp
      integer i,ix,iy,m,mp1
      end subroutine sswap

      !! ssymm.f
      subroutine ssymm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
      real alpha,beta
      integer lda,ldb,ldc,m,n
      character side,uplo
      real a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      real temp1,temp2
      integer i,info,j,k,nrowa
      logical upper
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine ssymm

      !! ssymv.f
      subroutine ssymv(uplo,n,alpha,a,lda,x,incx,beta,y,incy)
      real alpha,beta
      integer incx,incy,lda,n
      character uplo
      real a(lda,*),x(*),y(*)
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      real temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine ssymv

      !! ssyr2.f
      subroutine ssyr2(uplo,n,alpha,x,incx,y,incy,a,lda)
      real alpha
      integer incx,incy,lda,n
      character uplo
      real a(lda,*),x(*),y(*)
      real zero
      parameter (zero=0.0e+0)
      real temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine ssyr2

      !! ssyr2k.f
      subroutine ssyr2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      real alpha,beta
      integer k,lda,ldb,ldc,n
      character trans,uplo
      real a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      real temp1,temp2
      integer i,info,j,l,nrowa
      logical upper
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine ssyr2k

      !! ssyr.f
      subroutine ssyr(uplo,n,alpha,x,incx,a,lda)
      real alpha
      integer incx,lda,n
      character uplo
      real a(lda,*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,kx
      logical lsame
      end subroutine ssyr

      !! ssyrk.f
      subroutine ssyrk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
      real alpha,beta
      integer k,lda,ldc,n
      character trans,uplo
      real a(lda,*),c(ldc,*)
      logical lsame
      real temp
      integer i,info,j,l,nrowa
      logical upper
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine ssyrk

      !! stbmv.f
      subroutine stbmv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      real a(lda,*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical nounit
      logical lsame
      end subroutine stbmv

      !! stbsv.f
      subroutine stbsv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      real a(lda,*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical nounit
      logical lsame
      end subroutine stbsv

      !! stpmv.f
      subroutine stpmv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      real ap(*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,k,kk,kx
      logical nounit
      logical lsame
      end subroutine stpmv

      !! stpsv.f
      subroutine stpsv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      real ap(*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,k,kk,kx
      logical nounit
      logical lsame
      end subroutine stpsv

      !! strmm.f
      subroutine strmm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      real alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      real a(lda,*),b(ldb,*)
      logical lsame
      real temp
      integer i,info,j,k,nrowa
      logical lside,nounit,upper
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine strmm

      !! strmv.f
      subroutine strmv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      real a(lda,*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,kx
      logical nounit
      logical lsame
      end subroutine strmv

      !! strsm.f
      subroutine strsm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      real alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      real a(lda,*),b(ldb,*)
      logical lsame
      real temp
      integer i,info,j,k,nrowa
      logical lside,nounit,upper
      real one,zero
      parameter (one=1.0e+0,zero=0.0e+0)
      end subroutine strsm

      !! strsv.f
      subroutine strsv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      real a(lda,*),x(*)
      real zero
      parameter (zero=0.0e+0)
      real temp
      integer i,info,ix,j,jx,kx
      logical nounit
      logical lsame
      end subroutine strsv

      !! xerbla_array.f
      subroutine xerbla_array(srname_array, srname_len, info)
      integer srname_len, info
      character(1) srname_array(srname_len)
      integer i
      character(len=32) srname
      end subroutine xerbla_array

      !! xerbla.f
      subroutine xerbla( srname, info )
      character*(*)      srname
      integer            info
      end subroutine xerbla

      !! zaxpy.f
      subroutine zaxpy(n,za,zx,incx,zy,incy)
      complex(kind=8)  za
      integer incx,incy,n
      complex(kind=8)  zx(*),zy(*)
      integer i,ix,iy
      double precision dcabs1
      end subroutine zaxpy

      !! zcopy.f
      subroutine zcopy(n,zx,incx,zy,incy)
      integer incx,incy,n
      complex(kind=8)  zx(*),zy(*)
      integer i,ix,iy
      end subroutine zcopy

      !! zdotc.f
      complex(kind=8)  function zdotc(n,zx,incx,zy,incy)
      integer incx,incy,n
      complex(kind=8)  zx(*),zy(*)
      complex(kind=8)  ztemp
      integer i,ix,iy
      end function zdotc

      !! zdotu.f
      complex(kind=8)  function zdotu(n,zx,incx,zy,incy)
      integer incx,incy,n
      complex(kind=8)  zx(*),zy(*)
      complex(kind=8)  ztemp
      integer i,ix,iy
      end function zdotu

      !! zdrot.f
      subroutine zdrot( n, cx, incx, cy, incy, c, s )
      integer            incx, incy, n
      double precision   c, s
      complex(kind=8)    cx( * ), cy( * )
      integer            i, ix, iy
      complex(kind=8)    ctemp
      end subroutine zdrot

      !! zdscal.f
      subroutine zdscal(n,da,zx,incx)
      double precision da
      integer incx,n
      complex(kind=8)  zx(*)
      integer i,nincx
      end subroutine zdscal

      !! zgbmv.f
      subroutine zgbmv(trans,m,n,kl,ku,alpha,a,lda,x,incx,beta,y,incy)
      complex(kind=8)  alpha,beta
      integer incx,incy,kl,ku,lda,m,n
      character trans
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,iy,j,jx,jy,k,kup1,kx,ky,lenx,leny
      logical noconj
      logical lsame
      end subroutine zgbmv

      !! zgemm.f
      subroutine zgemm(transa,transb,m,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      complex(kind=8)  alpha,beta
      integer k,lda,ldb,ldc,m,n
      character transa,transb
      complex(kind=8)  a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp
      integer i,info,j,l,ncola,nrowa,nrowb
      logical conja,conjb,nota,notb
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine zgemm

      !! zgemv.f
      subroutine zgemv(trans,m,n,alpha,a,lda,x,incx,beta,y,incy)
      complex(kind=8)  alpha,beta
      integer incx,incy,lda,m,n
      character trans
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,iy,j,jx,jy,kx,ky,lenx,leny
      logical noconj
      logical lsame
      end subroutine zgemv

      !! zgerc.f
      subroutine zgerc(m,n,alpha,x,incx,y,incy,a,lda)
      complex(kind=8)  alpha
      integer incx,incy,lda,m,n
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jy,kx
      end subroutine zgerc

      !! zgeru.f
      subroutine zgeru(m,n,alpha,x,incx,y,incy,a,lda)
      complex(kind=8)  alpha
      integer incx,incy,lda,m,n
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jy,kx
      end subroutine zgeru

      !! zhbmv.f
      subroutine zhbmv(uplo,n,k,alpha,a,lda,x,incx,beta,y,incy)
      complex(kind=8)  alpha,beta
      integer incx,incy,k,lda,n
      character uplo
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kplus1,kx,ky,l
      logical lsame
      end subroutine zhbmv

      !! zhemm.f
      subroutine zhemm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
      complex(kind=8)  alpha,beta
      integer lda,ldb,ldc,m,n
      character side,uplo
      complex(kind=8)  a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp1,temp2
      integer i,info,j,k,nrowa
      logical upper
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine zhemm

      !! zhemv.f
      subroutine zhemv(uplo,n,alpha,a,lda,x,incx,beta,y,incy)
      complex(kind=8)  alpha,beta
      integer incx,incy,lda,n
      character uplo
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine zhemv

      !! zher2.f
      subroutine zher2(uplo,n,alpha,x,incx,y,incy,a,lda)
      complex(kind=8)  alpha
      integer incx,incy,lda,n
      character uplo
      complex(kind=8)  a(lda,*),x(*),y(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp1,temp2
      integer i,info,ix,iy,j,jx,jy,kx,ky
      logical lsame
      end subroutine zher2

      !! zher2k.f
      subroutine zher2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      complex(kind=8)  alpha
      double precision beta
      integer k,lda,ldb,ldc,n
      character trans,uplo
      complex(kind=8)  a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp1,temp2
      integer i,info,j,l,nrowa
      logical upper
      double precision one
      parameter (one=1.0d+0)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine zher2k

      !! zher.f
      subroutine zher(uplo,n,alpha,x,incx,a,lda)
      double precision alpha
      integer incx,lda,n
      character uplo
      complex(kind=8)  a(lda,*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,kx
      logical lsame
      end subroutine zher

      !! zherk.f
      subroutine zherk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
      double precision alpha,beta
      integer k,lda,ldc,n
      character trans,uplo
      complex(kind=8)  a(lda,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp
      double precision rtemp
      integer i,info,j,l,nrowa
      logical upper
      double precision one,zero
      parameter (one=1.0d+0,zero=0.0d+0)
      end subroutine zherk

      !! zhpmv.f
      subroutine zhpmv(uplo,n,alpha,ap,x,incx,beta,y,incy)
      complex(kind=8)  alpha,beta
      integer incx,incy,n
      character uplo
      complex(kind=8)  ap(*),x(*),y(*)
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine zhpmv

      !! zhpr2.f
      subroutine zhpr2(uplo,n,alpha,x,incx,y,incy,ap)
      complex(kind=8)  alpha
      integer incx,incy,n
      character uplo
      complex(kind=8)  ap(*),x(*),y(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp1,temp2
      integer i,info,ix,iy,j,jx,jy,k,kk,kx,ky
      logical lsame
      end subroutine zhpr2

      !! zhpr.f
      subroutine zhpr(uplo,n,alpha,x,incx,ap)
      double precision alpha
      integer incx,n
      character uplo
      complex(kind=8)  ap(*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,k,kk,kx
      logical lsame
      end subroutine zhpr

      !! zrotg.f
      subroutine zrotg(ca,cb,c,s)
      complex(kind=8)  ca,cb,s
      double precision c
      complex(kind=8)  alpha
      double precision norm,scale
      end subroutine zrotg

      !! zscal.f
      subroutine zscal(n,za,zx,incx)
      complex(kind=8)  za
      integer incx,n
      complex(kind=8)  zx(*)
      integer i,nincx
      end subroutine zscal

      !! zswap.f
      subroutine zswap(n,zx,incx,zy,incy)
      integer incx,incy,n
      complex(kind=8)  zx(*),zy(*)
      complex(kind=8)  ztemp
      integer i,ix,iy
      end subroutine zswap

      !! zsymm.f
      subroutine zsymm(side,uplo,m,n,alpha,a,lda,b,ldb,beta,c,ldc)
      complex(kind=8)  alpha,beta
      integer lda,ldb,ldc,m,n
      character side,uplo
      complex(kind=8)  a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp1,temp2
      integer i,info,j,k,nrowa
      logical upper
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine zsymm

      !! zsyr2k.f
      subroutine zsyr2k(uplo,trans,n,k,alpha,a,lda,b,ldb,beta,c,ldc)
      complex(kind=8)  alpha,beta
      integer k,lda,ldb,ldc,n
      character trans,uplo
      complex(kind=8)  a(lda,*),b(ldb,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp1,temp2
      integer i,info,j,l,nrowa
      logical upper
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine zsyr2k

      !! zsyrk.f
      subroutine zsyrk(uplo,trans,n,k,alpha,a,lda,beta,c,ldc)
      complex(kind=8)  alpha,beta
      integer k,lda,ldc,n
      character trans,uplo
      complex(kind=8)  a(lda,*),c(ldc,*)
      logical lsame
      complex(kind=8)  temp
      integer i,info,j,l,nrowa
      logical upper
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine zsyrk

      !! ztbmv.f
      subroutine ztbmv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      complex(kind=8)  a(lda,*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical noconj,nounit
      logical lsame
      end subroutine ztbmv

      !! ztbsv.f
      subroutine ztbsv(uplo,trans,diag,n,k,a,lda,x,incx)
      integer incx,k,lda,n
      character diag,trans,uplo
      complex(kind=8)  a(lda,*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,kplus1,kx,l
      logical noconj,nounit
      logical lsame
      end subroutine ztbsv

      !! ztpmv.f
      subroutine ztpmv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      complex(kind=8)  ap(*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,k,kk,kx
      logical noconj,nounit
      logical lsame
      end subroutine ztpmv

      !! ztpsv.f
      subroutine ztpsv(uplo,trans,diag,n,ap,x,incx)
      integer incx,n
      character diag,trans,uplo
      complex(kind=8)  ap(*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,k,kk,kx
      logical noconj,nounit
      logical lsame
      end subroutine ztpsv

      !! ztrmm.f
      subroutine ztrmm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      complex(kind=8)  alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      complex(kind=8)  a(lda,*),b(ldb,*)
      logical lsame
      complex(kind=8)  temp
      integer i,info,j,k,nrowa
      logical lside,noconj,nounit,upper
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine ztrmm

      !! ztrmv.f
      subroutine ztrmv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      complex(kind=8)  a(lda,*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,kx
      logical noconj,nounit
      logical lsame
      end subroutine ztrmv

      !! ztrsm.f
      subroutine ztrsm(side,uplo,transa,diag,m,n,alpha,a,lda,b,ldb)
      complex(kind=8)  alpha
      integer lda,ldb,m,n
      character diag,side,transa,uplo
      complex(kind=8)  a(lda,*),b(ldb,*)
      logical lsame
      complex(kind=8)  temp
      integer i,info,j,k,nrowa
      logical lside,noconj,nounit,upper
      complex(kind=8)  one
      parameter (one= (1.0d+0,0.0d+0))
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      end subroutine ztrsm

      !! ztrsv.f
      subroutine ztrsv(uplo,trans,diag,n,a,lda,x,incx)
      integer incx,lda,n
      character diag,trans,uplo
      complex(kind=8)  a(lda,*),x(*)
      complex(kind=8)  zero
      parameter (zero= (0.0d+0,0.0d+0))
      complex(kind=8)  temp
      integer i,info,ix,j,jx,kx
      logical noconj,nounit
      logical lsame
      end subroutine ztrsv

      end interface

      end module blas
