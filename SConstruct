#!python

from glob import glob
from os.path import join


general=['-fautomatic', '-funderscoring',
	# optimizations to always use because they might have side effects:
	'-fno-protect-parens', '-fno-signed-zeros', '-fno-trapping-math',
	# flags to use for strict checking:
	'-fimplicit-none', '-fmodule-private', '-pedantic', # 'Werror
	'-Wuse-without-only', '-Wimplicit-interface', '-Wimplicit-procedure']
FLAGS = dict(
	minimal=['-g', '-fbacktrace'],
	# flags to use in debug mode (-fcheck=all is for runtime):
	debug=general + ['-Og', '-g', '-Wall', '-Wextra', '-fbacktrace', '-fbounds-check',
		'-fmax-errors=1', '-ffpe-trap=invalid,zero,overflow,underflow,denormal', '-fcheck=all'],
	# flags to use in optimized mode:
	optimize=general + ['-Ofast', '-march=native', '-ffrontend-optimize'],
	# external libraries to link to:
	# libs=['-fopenmp', '-lblas', '-llapack', '-fexternal-blas'],
)

envs, dir, targets = {}, {}, {}
for mode in ('minimal', 'debug', 'optimize',):
	envs[mode] = Environment(
		FORTRANMODDIRPREFIX='-J',
		FORTRANMODDIR='${TARGET.dir}',
		FORTRANFLAGS=FLAGS[mode] + ['-fopenmp',],
		F08PATH=['${TARGET.dir}/../lib', '${TARGET.dir}/../lanczos'],
		LIBPATH=['${TARGET.dir}/../lib', '${TARGET.dir}/../lanczos'],
		F08FLAGS=['-std=f2008', '-ffree-form', '-ffree-line-length-none', '$FORTRANFLAGS'],
		F90FLAGS=['-std=legacy', '-ffixed-form',] + FLAGS['minimal'],
		CPPFLAGS='-cpp',
		CPPDEFINES=[mode[:3].upper()],
		LIBS=['blas', 'lapack',],
		LINKFLAGS=['-fopenmp'],
	)
	dir[mode] = 'build/{0:s}'.format(mode)
	envs[mode].VariantDir(variant_dir=dir[mode], src_dir='.', duplicate=True)
	sources = list(join(dir[mode], file) for file in glob('src/*.F08'))
	sources += list(join(dir[mode], file) for file in ['lib/blas.f90', 'lib/lapack.f90',])
	envs[mode].Depends(target=sources, dependency=['SConstruct'])
	targets[mode] = envs[mode].Program(join(dir[mode], 'main.run'), source=sources)
	envs[mode].Alias('{0:.3s}'.format(mode), targets[mode])
	Clean(targets[mode], 'build')

sources = list(join(dir['debug'], file) for file in ['lanczos/test_lanczos.F08', 'lanczos/lanczos.F08', 'lib/blas.f90', 'lib/lapack.f90',])
lanczos = envs['debug'].Program(join(dir['debug'], 'test_lanczos.run'), source=sources)
envs['debug'].Alias('lanczos', lanczos)

default_mode = 'debug'
test = Command(target='build/test.log', source=targets[default_mode], action="$SOURCE --initonly 2>&1 | tee $TARGET" )
envs[default_mode].Depends(test, targets[default_mode])
AlwaysBuild(test)
envs[default_mode].Alias('test', test)

envs[default_mode].Default(targets[default_mode])


