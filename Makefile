
# temporary directory
TMP := tmp

# the compiler to use:
COMP      :=  gfortran
# flags to always use so code is interpreted the same (except strict mode):
FALWAYS   := -ffree-form -ffree-line-length-none -fautomatic -funderscoring -cpp
# optimizations to always use because they might have side effects:
FALWAYS   += -fno-protect-parens -fno-signed-zeros -fno-trapping-math
# flags to use for strict checking:
FSTRICT   := -fimplicit-none -fmodule-private -std=f2008 -pedantic -Wuse-without-only -Wimplicit-interface -Wimplicit-procedure # -Werror
# flags to use in debug mode (-fcheck=all is for runtime):
FDEBUG    := -D DEB -Og -g -Wall -Wextra -fbacktrace -fbounds-check -fmax-errors=1 -ffpe-trap=invalid,zero,overflow,underflow,denormal -fcheck=all
# flags to use in optimized mode:
FOPTIMIZE := -D OPT -Ofast -march=native -ffrontend-optimize
# external libraries to link to:
FLIBS     := -lmpi -fcoarray=lib -lcaf_mpi -lblas -llapack -fexternal-blas
FLIBS     := -fopenmp -lblas -llapack -fexternal-blas
# pretty much all compiler warnings:
FWARNALL  := -Waliasing -Wampersand -Wconversion -Wsurprising -Wc-binding-type -Wintrinsics-std -Wtabs -Wintrinsic-shadow -Wline-truncation -Wtarget-lifetime -Winteger-division -Wreal-q-constant -Wunused -Warray-temporaries -Wcharacter-truncation -Wconversion-extra -Wunderflow -Wunused-dummy-argument -Wunused-parameter -Walign-commons -Wfunction-elimination -Wrealloc-lhs -Wrealloc-lhs-all -Wcompare-reals -Wzerotrip

# https://gcc.gnu.org/wiki/CoarrayLib
# ENV needed to make sure MPI uses the correct fortran compiler:
OMPI_FC=gfortran


default: deb
	@echo "ready"

CMD := $(COMP) $(FALWAYS) $(FSTRICT) $(FDEBUG)
deb: TMP := $(TMP)/deb
deb: main.deb.run

opt: CMD := $(COMP) $(FALWAYS) $(FSTRICT) $(FOPTIMIZE)
opt: TMP := $(TMP)/opt
opt: main.opt.run

main.%.run: $(TMP)/utils.o $(TMP)/multi_type.o $(TMP)/myopenmp.o $(TMP)/myopencl.o main.F08
	$(CMD) $^ -I $(TMP) -o $@ $(FLIBS)
	ln -f -s $@ main.run

.PRECIOUS: $(TMP)/%.o
$(TMP)/%.o: %.F08 $(TMP)/.init
	$(CMD) -c $< -I $(TMP) -J $(TMP) -o $@ $(FLIBS)

clean:
	rm -f main.deb.run main.opt.run main.run
	rm -rf $(TMP)/*

$(TMP)/.init:
	mkdir -p -m 700 $(TMP)
	@touch $(TMP)/.init

test: testrun

testrun: RUNTEST=yes
testrun: main.run
	@echo "#########################################"
	@echo "now testing that the program can start succesfully"
	./main.run --initonly


# -L/path/to/libcaf
# mpi.a


