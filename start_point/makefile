#Set this to @ to keep the makefile quiet
SILENCE = @

LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -lCppUTest -lCppUTestExt

#---- Outputs ----#
COMPONENT_NAME = Hiker

SRC_DIRS = \
  .

TEST_SRC_DIRS = \
  tests

INCLUDE_DIRS =\
	.\
	$(CPPUTEST_HOME)/include/ \

CXXFLAGS += -Wall -Wswitch-default -Wfatal-errors
CXXFLAGS += -std=c++2a
CFLAGS += -std=c18

include $(CPPUTEST_HOME)/build/MakefileWorker.mk
