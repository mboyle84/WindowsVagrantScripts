from __future__ import with_statement
from sikuli.Sikuli import *
 
class (object):
	

	def __init__(self):
		import platform
		import re
		print("Testing on the below platform")
		print(platform.platform())
		print("Setting screen area to full screen")
		self.appCoordinates = SCREEN
		print("Setting Variables for OS image sets")
		global BasePath
		if re.search("Windows_8", platform.platform()):
			BasePath = 'Win8.1/'
			print "Using image Sets", BasePath
		elif re.search("Windows_7", platform.platform()):
			BasePath = 'Win7/'
			print "Using image Sets", BasePath
		else:
			print("Cannot determine O.S Type to set images")	
			exit(1)
		
	def startApp(self):
		
		if exists(BasePath+"Minimize.png"):
			print("Minimizing powershell screen if it exits")
			click(BasePath+"Minimize.png");wait(1)
		print("Double Clicking on  Desktop Icon")
		print("Double Clicking on  Desktop Icon")
		doubleClick("ICON.png");
	def verifyApp(self):
		# check application
		count = 1
		max = 10
		while not exists(BasePath+"Disclaimer.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		if exists(BasePath+"Disclaimer.png"):
			print("PASS  Disclaimer window appeared")
		else:
			print("FAIL No  Disclaimer window")
			self.GenerateResults()
			exit(1)
	def License(self):
		print("Clicking on Ok Button")
		click( "OK.png");wait(10)
		print("Typing in Activation Key")
		type(Key.TAB+"XXXXX"+Key.TAB+Key.ENTER);wait(5)
		count = 1
		max = 10
		while not exists(BasePath+"RootFolder.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		if exists(BasePath+"RootFolder.png"):
			print("PASS  RootFolder window appeared")
		else:
			print("FAIL No  RootFolder window")
			self.GenerateResults()
			exit(1)
	def RootFolderSet(self):
		print("Typing in directory path of images")
		type("C:\\tmp\\Images\\"+Key.TAB+Key.TAB+Key.ENTER);wait(30)
		print("Clicking on DB Refresh")
		click( "DBREFRESH.png");wait(1)
		count = 1
		max = 15
		while not exists(BasePath+"DatabaseRefreshDone.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		if exists(BasePath+"DatabaseRefreshDone.png"):
			print("PASS  DatabaseRefresh window appeared")
		else:
			print("FAIL No  DatabaseRefresh window")
			self.GenerateResults()
			exit(1)
		count = 1
		max = 10
		while not exists("Done.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		print("Clicking on Done Button")
		click( "Done.png");wait(5)
	def PerformTest(self):
		print("Tabbing to first test")
		#click( "Test1.png");wait(5)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.TAB);wait(1)
		type(Key.DOWN, KeyModifier.CTRL);wait(1)
		print("Clicking on RunTest Button")
		click( "RunTest.png");wait(5)
		count = 1
		max = 10
		while not exists(BasePath+"ImageProcessing.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		if exists(BasePath+"ImageProcessing.png"):
			print("PASS  Image Processing window appeared")
		else:
			print("FAIL No  Image Processing window")
		count = 1
		max = 10
		while not exists("Start.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		print("Clicking on Start Button")
		click( "Start.png");wait(15)
		
		if exists(BasePath+"ImageProcessingStarted.png"):
			print("PASS  Image Processing Started window appeared")
		else:
			print("FAIL No  Image Processing Started window")
			self.GenerateResults()
			exit(1)
		count = 1
		max = 50
		while not exists("Finished.png"):
			print(str(count)) # to prevent a conversion error
			sleep(5)
     			count += 1
     			if count > max: break
		print("Clicking on Finish Button")
		click( "Finished.png");wait(5)
	def GenerateResults(self):

		print("Taking screenshot")
		import shutil
		import os
		#some_region = App.focusedWindow() #just front image
		some_region = SCREEN # for whole screen
		screenshotsDir = "C:\\vagrant\\Testing\\Test.sikuli\\"
		img = capture(some_region)
		shutil.move(img, os.path.join(screenshotsDir, "Results.png"))
		my_dir = "C:\\tmp\\Testing\\Test.sikuli\\"
		el = "\n" # the end of line you want to use
		my_file = file(my_dir +'Done.txt','a')
		my_file.write("Completed"+el)
		my_file.close()
		print("Deactivating Windows")
		cmd = r'"$env:SystemRoot\system32\slmgr.vbs"  /upk'
		openApp(cmd)
		print("Testing Completed, copying files to vagrant share for jenkins to check results")
		source= 'C:\\tmp\\Testing\\Test.sikuli\\TestResults.txt'
		dest= 'E:\\Testing\\Test.sikuli\\TestResults.txt'
		shutil.move( source, dest)
		source= 'C:\\tmp\\Testing\\Test.sikuli\\Results.png'
		dest= 'E:\\Testing\\Test.sikuli\\Results.png'
		shutil.move( source, dest)
		

	def runTest(self):
		self.startApp()
		self.verifyApp()
		self.License()
	 	self.RootFolderSet()
		self.PerformTest()
		self.GenerateResults()
		
	
if __name__ == "__main__":
	Test = ()
	Test.runTest()

	