
"""
This is a very crude script to extract interfaces from Fortran source files,
that nonetheless seems to work well enough for netlib blas and lapack.
"""

from re import sub as re_sub, findall, IGNORECASE, MULTILINE
from sys import argv, stderr
from os.path import exists, basename

stderr.write('First argument is module name, all others are input files.\n')
stderr.write('This could increase the length of some lines by up to 6 characters, which might cause lines to become too long.\n')

"""
Get and check arguments.
"""
if len(argv) < 2:
	stderr.write('no output target provided\n')
	exit(4)
modname = argv[1]

targets = argv[2:]
quit = False

if not targets:
	stderr.write('no targets provided\n')
	exit(2)

for target in targets:
	if not exists(target):
		stderr.write('could not find "{0:s}"\n'.format(target))
		quit = True

if quit:
	exit(3)

"""
Read the source files.
"""
iface_words = {'function', 'end function', 'subroutine', 'end subroutine', 'recursive', 'pure', 'elemental',
	'integer', 'real', 'double', 'complex', 'character', 'logical', 'parameter',}
output = ['      !! automatically generated interface', '      !! pipe a .f90 file & compile with -ffixed-form',
	'', '      module {0:s}'.format(modname), '', '      public', '', '      interface', '']
for target in targets:
	stderr.write('.')
	with open(target, 'r') as fh:
		lines = fh.read().lower().splitlines()
		output.append('      !! {0:s}'.format(basename(target)))
	next_too = False
	sub = []
	for line in lines:
		line = line.rstrip()
		code = line.lstrip()
		code = re_sub(r'"[^"]*"', '""', code)
		code = re_sub(r'\'[^\']*\'', '\'\'', code)
		if code.startswith('*') or code.startswith('c..'):
			code = ''
		code = code.split('!')[0]
		# if code.endswith(','):
		# 	line += '&'
		if next_too or any(code.startswith(word) for word in iface_words):
			if sub and 'end' not in code and ('subroutine' in code or 'function' in code):
				stderr.write('skipping the rest of "{0:s}"\n'.format(target))
				break
			sub.append(line)
			next_too = False
			if code.endswith(',') or code.endswith('&'):
				next_too = True
	if len(sub) and not 'end subroutine' in sub[-1] and not 'end function' in sub[-1]:
		strt = findall(r'(function|subroutine)\s+(\w+)\s*\(', sub[0])
		if not strt:
			stderr.write('could not determine appropriate ending for "{0:s}"'.format(sub[0]))
			continue
		sub.append('      end {0:s} {1:s}'.format(strt[0][0], strt[0][1]))
		# if 'function' in sub[0]:
		# 	sub.append('      end function')
		# elif 'subroutine' in sub[0]:
		# 	sub.append('      end subroutine')
		# else:
		# 	stderr.write('invalid ending for "{0:s}" in "{1:s}"\n'.format(sub[0], target))
		# 	continue
	output.extend(sub)
	output.append('')
output.extend(['      end interface', '', '      end module {0:s}'.format(modname)])
content = '\n'.join(output)
content = re_sub(r'^(\s+)\$', r'\g<1>&', content, flags=MULTILINE)
content = re_sub(r'(integer|real)\s*\*(\s*\d+\s*)\s{1,7}', r'\1(kind=\2) ', content, flags=IGNORECASE)
stderr.write('complex types not converted since *16 is not the same as kind=16\n')
content = re_sub(r'character\*(\d+)\s{1,6}', r'character(len=\1) ', content, flags=IGNORECASE)
print(content)
# print(findall(r'^(\s+)\$', content, MULTILINE))
stderr.write('done\n')


