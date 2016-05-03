#!python

from glob import glob
from os.path import join, basename

# problems:
# todo: modules not in variantdir -> this is partially caused by -j4, without which it builds in both
# todo: (compiles some unnecessary objects)
# todo: opt and deb modes
# todo: blas doesn't work because libflags appear before .o files
# todo: most flags aren't added at all
# todo: dependency on SConstruct not working
# todo: only one openmp thread?
# todo: optimized mode doesn't actually optimize

general=['-fautomatic', '-funderscoring',
	# optimizations to always use because they might have side effects:
	'-fno-protect-parens', '-fno-signed-zeros', '-fno-trapping-math',
	# flags to use for strict checking:
	'-fimplicit-none', '-fmodule-private', '-pedantic',
	'-Wuse-without-only', '-Wimplicit-interface', '-Wimplicit-procedure'] # 'Werror
FLAGS = dict(
	minimal=['-g', '-fbacktrace'],
	# flags to use in debug mode (-fcheck=all is for runtime):
	debug=general + ['-Og', '-g', '-Wall', '-Wextra', '-fbacktrace', '-fbounds-check',
		'-fmax-errors=1', '-ffpe-trap=invalid,zero,overflow,underflow,denormal', '-fcheck=all'],
	# flags to use in optimized mode:
	optimize=general + ['-Ofast', '-march=native', '-ffrontend-optimize'],
	# external libraries to link to:
	# libs=['-fopenmp', '-lblas', '-llapack', '-fexternal-blas'],
	# note: -fopenmp should for in LINKFLAGS but it doesn't automatically so it is repeated manually
)


envs, targets = {}, {}
for mode in ('minimal', 'debug', 'optimize',):
# for mode in ('debug',):
	# $F08 -o $TARGET -c $F08FLAGS $CPPFLAGS $_CPPDEFFLAGS $_F08INCFLAGS $_FORTRANMODFLAG $SOURCES
	# LINKCOM = $LINK -o $TARGET $LINKFLAGS $__RPATH $SOURCES $_LIBDIRFLAGS $_LIBFLAGS
	envs[mode] = Environment(
		FORTRANMODDIRPREFIX='-J',
		FORTRANMODDIR='${TARGET.dir}',
		# _FORTRANMODFLAG=FLAGS['always'] + FLAGS['strict'],
		# FORTRANFLAGS=FLAGS['always'] + FLAGS['strict'],
		# FORTRANCOM='$FORTRAN -o $TARGET -c $FORTRANFLAGS $CPPFLAGS $_CPPDEFFLAGS $_FORTRANINCFLAGS $_FORTRANMODFLAG $SOURCES #YOOLOOOO1',
		# FORTRANPPCOM='$FORTRAN -o $TARGET -c $FORTRANFLAGS $CPPFLAGS $_CPPDEFFLAGS $_FORTRANINCFLAGS $_FORTRANMODFLAG $SOURCES #YOOLOOOO2',
		# F08COM='$F08 -o $TARGET -c $F08FLAGS $_F08INCFLAGS $_FORTRANMODFLAG $SOURCES #YOOLOOOO3',
		# F08PPCOM='$F08 -o $TARGET -c $F08FLAGS $CPPFLAGS $_CPPDEFFLAGS $_F08INCFLAGS $_FORTRANMODFLAG $SOURCES #YOOLOOOO4',
		FORTRANFLAGS=FLAGS[mode] + ['-fopenmp',],# '-I${TARGET.dir}/../lib',],  # todo: -I necessary?
		F08PATH='${TARGET.dir}/../lib',
		F08FLAGS=['-std=f2008', '-ffree-form', '-ffree-line-length-none', '$FORTRANFLAGS'],
		F90FLAGS=['-std=legacy', '-ffixed-form',] + FLAGS['minimal'],
		CPPFLAGS='-cpp',
		CPPDEFINES=[mode[:3].upper()],
		LIBS=['blas', 'lapack',],
		LINKFLAGS=['-fopenmp'],
		# _LIBFLAGS=FLAGS['libs'],
	)
	# for k, v in envs[mode].ParseFlags(sum(FLAGS.values(), [])).items():
	# 	print(' {0:s} = {1:}'.format(k, v))
	# if mode == 'debug':
	# 	for k, v in sorted(envs[mode].items()):
	# 		print('>> {0:s} = {1:}'.format(k, v))
	dir = 'build/{0:s}'.format(mode)
	# envs[mode].VariantDir(variant_dir=dir, src_dir=['src', 'lib'], duplicate=True)
	envs[mode].VariantDir(variant_dir=join(dir, 'src'), src_dir='src', duplicate=True)
	envs[mode].VariantDir(variant_dir=join(dir, 'lib'), src_dir='lib', duplicate=True)
	# envs[mode].VariantDir(variant_dir=join(dir, 'lib'), src_dir='lib', duplicate=True)
	sources = list(join(dir, file) for file in glob('src/*.F08'))
	sources += list(join(dir, file) for file in ['lib/blas.f90', 'lib/lapack.f90',])
	# objs = []
	# for src in sources:
	# 	objs.append(envs[mode].Object(source=src)[0])
	# print(sources)
	envs[mode].Depends(target=sources, dependency=['SConstruct'])
	# blas = envs[mode].Object(source=join(dir, 'lib/blas.f90'))
	# lapack = envs[mode].Object(source=join(dir, 'lib/lapack.f90'))
	# print([str(obj) for obj in objs])
	print('>>', mode, envs[mode])
	targets[mode] = envs[mode].Program(join(dir, 'main.run'), source=sources)
	# for src in sources:
	# 	envs[mode].Depends(target=src, dependency='SConstruct')
	envs[mode].Alias('{0:.3s}'.format(mode), targets[mode])

envs['debug'].Default(targets['debug'])


