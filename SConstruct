#!python

from glob import glob
from os.path import join


# problems:
# todo: modules not in variantdir -> this is partially caused by -j4, without which it builds in both
# todo: (compiles some unnecessary objects)
# todo: opt and deb modes


FLAGS = dict(
	always=['-ffree-form', '-ffree-line-length-none', '-fautomatic', '-funderscoring', '-cpp',
	# optimizations to always use because they might have side effects:
		'-fno-protect-parens', '-fno-signed-zeros', '-fno-trapping-math'],
	# flags to use for strict checking:
	strict=['-fimplicit-none', '-fmodule-private', '-std=f2008', '-pedantic',
		'-Wuse-without-only', '-Wimplicit-interface', '-Wimplicit-procedure'], # 'Werror
	# flags to use in debug mode (-fcheck=all is for runtime):
	debug=['-D DEB', '-Og', '-g', '-Wall', '-Wextra', '-fbacktrace', '-fbounds-check',
		'-fmax-errors=1', '-ffpe-trap=invalid,zero,overflow,underflow,denormal', '-fcheck=all'],
	# flags to use in optimized mode:
	optimize=['-D OPT', '-Ofast', '-march=native', '-ffrontend-optimize'],
	# external libraries to link to:
	libs=['-fopenmp', '-lblas', '-llapack', '-fexternal-blas'],
	# note: -fopenmp should for in LINKFLAGS but it doesn't automatically so it is repeated manually
)

envs, targets = {}, {}
for mode in ('debug', 'optimize',):
# for mode in ('debug',):
	dir = 'build/{0:s}'.format(mode)
	envs[mode] = DefaultEnvironment(
		FORTRANMODDIRPREFIX = '-J',
		FORTRANMODDIR = '${TARGET.dir}',
		LINKFLAGS='-fopenmp',
	)
	envs[mode].ParseFlags(
		FLAGS['always'] +
		FLAGS['strict'] +
		FLAGS[mode] +
		FLAGS['libs']
	)
	envs[mode].VariantDir(variant_dir=dir, src_dir='.', duplicate=True)
	sources = list(join(dir, file) for file in glob('*.F08'))
	targets[mode] = envs[mode].Program(join(dir, 'main.run'), source=sources)
	for src in sources:
		envs[mode].Depends(target=src, dependency='SConstruct')
	envs[mode].Alias('{0:.3s}'.format(mode), targets[mode])

envs['debug'].Default(targets['debug'])


