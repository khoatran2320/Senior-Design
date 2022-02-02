def read_txt_file(fn):
	with open(fn) as f:
		lines = [line.rstrip('\n') for line in f]
		return lines

def write_txt_file(fn, content):
	with open(fn,  'w') as f:
		f.write(content)
		
