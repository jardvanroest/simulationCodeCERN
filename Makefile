COMPILER_VERSION := "$(CXX)-$(shell $(CXX) --version | head -n1 | cut -d' ' -f4)"
BUILD_HOST := $(shell sh -c './BUILD-HOST-GEN')

CFLAGS = -DCOMPILER_VERSION=\"$(COMPILER_VERSION)\" -DBUILD_HOST=\"$(BUILD_HOST)\"

CFLAGS += -O2

PLATFORM:=$(shell uname)

HDRS = util.hpp
SRCS = cell_clustering.cpp util.cpp
ifeq ($(PLATFORM),Darwin)
OSX_VERSION := $(shell sw_vers | sed -n 's/ProductVersion://p'|awk '{ if (NR==1) print $$1 }')
CFLAGS += -DOSX_VERSION=\"$(OSX_VERSION)\"
else
RTLIB = -lrt
endif

cell_clustering: $(HDRS) $(SRCS) Makefile
	$(CXX) -o $@ $(SRCS) $(CFLAGS) -Wall $(RTLIB)

clean:
	rm -rf cell_clustering cell_clustering.dSYM
