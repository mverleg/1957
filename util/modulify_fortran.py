
#todo: everything

"""
This is a very crude script to find the information needed to
turn a Fortran codebase into modules which match the files.
"""

from collections import defaultdict
from os import getcwd
from re import findall
from sys import argv, stdout, stderr
from os.path import exists, basename, abspath


"""
Get and check arguments.
"""
targets = list(sorted(argv[1:]))
quit = False

if not targets:
	stderr.write('no targets provided\n')
	exit(2)

for target in targets:
	if target.startswith('-'):
		continue
	if not exists(target):
		stderr.write('could not find "{0:s}"\n'.format(target))
		quit = True

if quit:
	exit(1)

"""
Set some ignored names that can be called without import.
"""
ignore = {'mpi_finalize', 'mpi_comm_size', 'mpi_comm_rank', 'mpi_recv', 'mpi_send', 'mpi_allreduce', 'flush', 'flush_', 'getenv'}

"""
Read the source files.
"""
file_defines = defaultdict(list)
defined_in = {}
called_in = defaultdict(set)
file_calls = defaultdict(set)
for target in targets:
	if target.startswith('-'):
		continue
	with open(target, 'r') as fh:
		content = fh.read().lower()
	for defi in findall(r'(?:function|subroutine)\s+(\w+)\s*\(', content):
		if defi in defined_in:
			stderr.write('{0:s} from {1:s} redefined in {2:s}\n'.format(defi, defined_in[defi], target))
		defined_in[defi] = target
		file_defines[target].append(defi)
	for calli in findall(r'call\s+(\w+)\s*\(', content):
		called_in[calli].add(target)
		file_calls[target].add(calli)

"""
Construct use statements.
"""
def modname(pth):
	return basename(pth.split('.')[0]) + '_mod'

use = defaultdict(lambda: defaultdict(set))
for file, fcalls in file_calls.items():
	frm = defaultdict(list)
	for call in fcalls:
		if call in ignore:
			continue
		if call in defined_in:
			if file != defined_in[call]:
				# name = basename(defined_in[call].split('.')[0]) + '_mod'
				use[file][modname(defined_in[call])].add(call)
		else:
			use[file][None].add(call)
			# stderr.write('don\'t know where {0:s} is defined (called from {1:s})\n'.format(call, file))

"""
Construct modules (including use statements).
"""
for file, routines in file_defines.items():
	stderr.write('{0:s}\n'.format(file))
	pre = '      module {0:s}\n'.format(modname(file))
	for src, calls in use[file].items():
		if src is not None:
			pre += '      use {0:s}, only: {1:s}\n'.format(src, ', '.join(calls))
	if None in use[file]:
		pre += '      !! unknown origin: {0:s}\n'.format(', '.join(use[file][None]))
	pre += '      private\n'
	public, internal = [], []
	for routine in routines:
		if {file} != called_in[routine]:
			public.append(routine)
		else:
			internal.append(routine)
	pre += '      public {0:s}\n'.format(', '.join(public))
	if internal:
		pre += '      !! internal: {0:s}\n'.format(', '.join(internal))
	pre += '      contains\n'
	post = '      end module {0:s}\n'.format(modname(file))
	"""
	Apply the changes if requested. This will probably need manual fixing after.
	"""
	if '--apply' in argv[1:]:
		if file.startswith('-') or getcwd() not in abspath(file):
			continue
		with open(file, 'r') as fh:
			content = fh.read()
		if 'module' in content.lower():
			stderr.write('{0:s} already has a module, not applying\n'.format(file))
			continue
		with open(file, 'w') as fh:
			stderr.write('turning {0:s} into module'.format(file))
			fh.write('\n' + pre + '\n')
			fh.write(content + '\n')
			fh.write(post + '\n')
	else:
		stdout.write(pre)
		stdout.write('\n')
		stdout.write(post)



