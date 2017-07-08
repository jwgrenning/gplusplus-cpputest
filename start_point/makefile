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

CXXFLAGS += -Wall -Werror -Wswitch-default -Wfatal-errors
CXXFLAGS += -std=c++17
CFLAGS += -std=c99

include $(CPPUTEST_HOME)/build/MakefileWorker.mk
