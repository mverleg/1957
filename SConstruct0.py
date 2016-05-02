#!python

from glob import glob
from os.path import join


# problems:
# todo: modules not in variantdir -> this is partially caused by -j4, without which it builds in both
# todo: cannot compile openmp
# todo: (compiles some unnecessary objects)


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
)

envs, targets = {}, {}
# for mode in ('debug', 'optimize',):
for mode in ('debug',):
	dir = 'build/{0:s}'.format(mode)
	# q = '$FORTRAN -o$TARGET -c $FORTRANFLAGS $FORTRANMODDIRPREFIX$FORTRANMODDIR $_FORTRANINCFLAGS $SOURCES'
	envs[mode] = DefaultEnvironment(# tools=('gfortran',),
		FC='gfortran', FORTRAN='gfortran', # BUILDERS=['gfortran'], LINK='gfortran',
		# FORTRANMODDIRPREFIX = '-J',
		# FORTRANMODDIR=dir,

		# FORTRANMODDIRPREFIX = '-J',
		# FORTRANMODDIR = '${TARGET.dir}',
		# FORTINCPREFIX = '-I',
		#
		# _FORTRANINCFLAGS = '$( ${_concat(FORTINCPREFIX, FORTRANPATH, INCSUFFIX, __env__, RDirs, TARGET, SOURCE)} $)',
		# FORTRANCOM = q,
		# SHFORTRANCOM = q,
		# SHF90PPCOM = q,
		# SHF95PPCOM = q,
		# F90PPCOM = q,
		# F95PPCOM = q,

		# FORTRANPATH=dir,
		# SHELL='bash',
		# PATH=environ.get('PATH', ''),
		# LIBRARY_PATH=environ.get('LIBRARY_PATH', ''),
		# LD_LIBRARY_PATH=environ.get('LD_LIBRARY_PATH', ''),
	)
	envs[mode] = DefaultEnvironment(tools=['default', 'gfortran'], F08='gfortran', F08FLAGS='-g', LINK='gfortran', LINKFLAGS='-g')
	# for k, v in envs[mode].items():
	# 	print('{0:s} = {1:}'.format(k, v))
	# ['-J tmp/', '-I tmp/']
	envs[mode].ParseFlags(
		FLAGS['always'] +
		FLAGS['strict'] +
		FLAGS[mode] +
		FLAGS['libs']
	)
	# for k, v in sorted(envs[mode].items()):
	# 	if not k.startswith('_'):
	# 		print('{0:s} = {1:}'.format(k, v))
	# [stdout.write('{0:s} = {1:}\n'.format(k, v)) for k, v in debenv.items()]
	envs[mode].VariantDir(variant_dir=dir, src_dir='.', duplicate=True)

	# s = FortranScan()
	# path = s.path(env)
	# deps = s(env.File('fff1.f'), env, path)

	# debtarget = envs[mode].Program(join(mode, 'main.{0:3s}.run').format(mode), source=Glob('*.F08'))

	# print('scan', envs[mode]['SCANNERS'])
	# envs[mode].Append(SCANNERS=Scanner.Fortran.F90Scanner)
	# envs[mode].Command('foo', 'foo.k', 'kprocess < $SOURCES > $TARGET')

	sources = list(join(dir, file) for file in glob('*.F08'))
	print(sources)
	targets[mode] = envs[mode].Program(join(dir, 'main.{0:.3s}.run'.format(mode)), source=sources)
	envs[mode].Depends(target=targets[mode], dependency='SConstruct')
	envs[mode].Alias('{0:.3s}'.format(mode), targets[mode])


# optenv = Environment()
# debenv.ParseFlags(FLAGS['always'] + FLAGS['strict'] + FLAGS['optimize'] + FLAGS['libs'])
# todo: dependencies in opt mode
# optenv.VariantDir(variant_dir='optimized', src_dir='.')
# debtarget = debenv.Program('main.opt.run', source=Glob('*.F08'))
# debenv.Alias('opt', debtarget)
#

envs['debug'].Default(targets['debug'])
# debenv.Default(debtarget)



# FortranScan
#
# # Comment lines start with the # symbol
# # The following sets up an Compile Environment Object with gfortran as the linker.
# env=Environment(LINK='gfortran')
# # The next line of code is an array of the source files names used in the program.
# sources=['TestMod.f90','main.f90']
# # The next line is the actual code that links the executable. env.Program is generates an executable.
# objs=env.Program('test.exe', sources)
#
#
#
# setup=argv.get('SETUP', None)
# if setup is None:
# 	setup=[ None ]
# else:
# 	parts=setup.split(os.pathsep)
# setup=[]
# for part in parts:
# 	setup.extend(glob.glob(part))
# if len(setup) == 0:
# 	print 'SETUP specified but no matching setup files found'
# 	Exit()
#
#
