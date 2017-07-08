#Set this to @ to keep the makefile quiet
SILENCE = @

CXXFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorNewMacros.h
CFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorMallocMacros.h

LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -lCppUTest -lCppUTestExt

#---- Outputs ----#
COMPONENT_NAME = Hiker

#--- Inputs ----#
PROJECT_HOME_DIR = .

SRC_FILES = Hiker.cpp

TEST_SRC_FILES = AllTests.cpp HikerTest.cpp

INCLUDE_DIRS =\
	.\
	$(CPPUTEST_HOME)/include/ \
	$(CPPUTEST_HOME)/include/Platforms/Gcc\

CPPUTEST_WARNINGFLAGS = -Wall -Werror -Wswitch-default -Wfatal-errors
CPPUTEST_CXXFLAGS = -std=c++17
CPPUTEST_CFLAGS = -std=c99

include $(CPPUTEST_HOME)/build/MakefileWorker.mk
