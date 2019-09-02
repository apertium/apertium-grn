"""
	Generate a file with a list of forms and 1 - their relative frequency
"""
import sys, math as maths
forms = {};  # dictionary of form → analysis → frequency
total = 0

def form_total(f):
	# Returns the total number of analyses for a form
	total = 0
	[total += i for i in f]
	return total	


# ^oho/oho<v><iv><p3><pres>$
# ^oho/oho<v><iv><p3><pres>$
# ^oho/o<prn><p3><ac>+ho<v><iv><pres>$
for line in sys.stdin.readlines():
	row = line.strip()[1:-1].split('/')
	form = row[0]
	analysis = row[1]
	if form not in f:
		forms[form] = {} 
	if analysis not in forms[form]:
		forms[form][analysis] = 0
	forms[form][analysis] += 1

# oho<v><iv><p3><pres>:oho	0.3333
# o<prn><p3><ac>+ho<v><iv><pres>:oho	0.6666
for form in forms: 
	total = form_total(forms[form])
	for analysis in forms[form]:
		print('%s:%s\t%.4f' % (analysis, form, 1.0-(forms[form][analysis]/total)))

