
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
targets = argv[1:]
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
defines = defaultdict(list)
defined_in = {}
called_in = defaultdict(set)
calls = defaultdict(set)
for target in targets:
	if target.startswith('-'):
		continue
	with open(target, 'r') as fh:
		content = fh.read().lower()
	for defi in findall(r'(?:function|subroutine)\s+(\w+)\s*\(', content):
		if defi in defined_in:
			stderr.write('{0:s} from {1:s} redefined in {2:s}\n'.format(defi, defined_in[defi], target))
		defined_in[defi] = target
		defines[target].append(defi)
	for calli in findall(r'call\s+(\w+)\s*\(', content):
		called_in[calli].add(target)
		calls[target].add(calli)

"""
Construct use statements.
"""
use = defaultdict(lambda: defaultdict(set))
for file, fcalls in calls.items():
	frm = defaultdict(list)
	for call in fcalls:
		if call in ignore:
			continue
		if call in defined_in:
			if file != defined_in[call]:
				name = basename(defined_in[call].split('.')[0])
				use[file][name].add(call)
		else:
			use[file][None].add(call)
			# stderr.write('don\'t know where {0:s} is defined (called from {1:s})\n'.format(call, file))

"""
Construct modules (including use statements).
"""
for file, routines in defines.items():
	stderr.write('{0:s}\n'.format(file))
	stdout.write('      module {0:s}\n'.format(file.split('.')[0]))
	for src, calls in use[file].items():
		if src is not None:
			stdout.write('      use {0:s}, only: {1:s}\n'.format(src, ', '.join(calls)))
	if None in use[file]:
		stdout.write('      !! unknown origin: {0:s}\n'.format(', '.join(use[file][None])))
	stdout.write('      private\n')
	public, internal = [], []
	for routine in routines:
		if {file} != called_in[routine]:
			public.append(routine)
		else:
			internal.append(routine)
	stdout.write('      public {0:s}\n'.format(', '.join(public)))
	if internal:
		stdout.write('      !! internal: {0:s}\n'.format(', '.join(internal)))
	stdout.write('      contains\n')
	stdout.write('      \n')
	stdout.write('      end module {0:s}\n'.format(file.split('.')[0]))


"""
Apply the changes if requested. This will probably need manual fixing after.
"""
if '--apply' in argv[1:]:
	for target in targets:
		if target.startswith('-') or getcwd() not in abspath(target):
			continue
		with open(target, 'r') as fh:
			content = fh.read()
		if 'module' in content.lower():
			stderr.write('{0:s} already has a module, not applying\n'.format(target))
			continue



