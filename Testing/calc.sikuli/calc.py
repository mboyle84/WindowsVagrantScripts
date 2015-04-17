from __future__ import with_statement
from sikuli.Sikuli import *
 
class Calculator(object):
	
	def __init__(self):
		self.appCoordinates = (0, 0, 1024, 768)
	
	def startApp(self):
		calcApp = App("Calculator")
		if not calcApp.window():
				App.open("calc.exe"); wait(2)
		calcApp.focus(); wait(1)
 
	def verifyApp(self):
		# check application
		if exists("CalcApp.png"):
			print("PASS: Calculator window appeared")
			my_dir = "C:\\vagrant\\MRIDTesting\\calc.sikuli\\"
			el = "\n" # the end of line you want to use
			my_file = file(my_dir +'TestResults.txt','a')
			my_file.write("PASS: Calculator window appeared"+el)
			my_file.close()
		else:
			print("FAIL: No calculator window")
			my_dir = "C:\\vagrant\\MRIDTesting\\calc.sikuli\\"
			el = "\n" # the end of line you want to use
			my_file = file(my_dir +'TestResults.txt','a')
			my_file.write("FAIL: No calculator window"+el)
			my_file.close()
 
	def performAction(self, *args):
		# get application region
		find("CalcApp.png")
		
		match = getLastMatch()
		self.appCoordinates = (match.getX(), match.getY(), match.getW(), match.getH())
		appRegion = Region(*self.appCoordinates)
		
		#rewrite action
		action = args[1]
		if args[1] == '+':
			action = 'Plus'
		elif args[1] == 'exp':
			action = 'Exp'
		
		with appRegion:
			click("btnC.png")
 
			click( "btn%s.png" % (args[0],) )
			click( "btn%s.png" % (action,) )
			click( "btn%s.png" % (args[2],) )
 
			click("btnEqual.png")
 
	def verifyResult(self, *args):
		expected_result = str(eval(''.join(args)))
		actual_result = self.getResultFromClipboard()
		
		#verification
		if actual_result == expected_result:
			print("PASS: Action performed correctly and result equals %s" % expected_result)
			my_dir = "C:\\vagrant\\MRIDTesting\\calc.sikuli\\"
			el = "\n" # the end of line you want to use
			my_file = file(my_dir +'TestResults.txt','a')
			my_file.write("PASS: Action performed correctly and result equals %s" % expected_result+el)
			my_file.close()
		else:
			print("FAIL: Actual result '%s' is not equal to expected result '%s'" % (actual_result, expected_result))
			my_dir = "C:\\vagrant\\MRIDTesting\\calc.sikuli\\"
			el = "\n" # the end of line you want to use
			my_file = file(my_dir +'TestResults.txt','a')
			my_file.write("FAIL: Actual result '%s' is not equal to expected result '%s'" % (actual_result, expected_result)+el)
			my_file.close()
		
	def getResultFromClipboard(self):
		type('c', KEY_CTRL)
		return str(Env.getClipboard())
		
	def runTest(self):
		self.startApp()
		self.verifyApp()
		
		actions = '2+2'
		self.performAction(*actions)
		self.verifyResult(*actions)
 
if __name__ == "__main__":
	calc = Calculator()
	calc.runTest()