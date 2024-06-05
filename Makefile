
NAME := protobufsample

SRCS := main.cpp person.pb.cc
LIBS := -lprotobuf -lpthread
# If -lpthread is missing, the following error occurs
# > terminate called after throwing an instance of 'std::system_error'
# >  what():  Unknown error -1


CC := gcc
CXX := g++
LD := $(CXX)
CFLAGS := -O3
CXXFLAGS := -O3 -std=c++17

OBJS := $(SRCS:%.c=%.o)
OBJS := $(OBJS:%.cpp=%.o)
OBJS := $(OBJS:%.cc=%.o)
DEPS := $(SRCS:%.c=%.d)
DEPS := $(DEPS:%.cpp=%.d)
DEPS := $(DEPS:%.cc=%.d)

all: $(NAME)

$(NAME): $(OBJS)
	$(info OBJS = $(OBJS))
	$(LD) $(OBJS) -o $(NAME) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -MMD -MP -MF $(<:%.c=%.d) -c $<

.cpp.o:
	$(CXX) $(CXXFLAGS) -MMD -MP -MF $(<:%.cpp=%.d) -c $<

.cc.o:
	$(CXX) $(CXXFLAGS) -MMD -MP -MF $(<:%.cc=%.d) -c $<

.PHONY: clean
clean:
	rm -f $(NAME) *.o *.d

.PHONY: run
run:
	./$(NAME)

.PHONY: install
install:
	install -m 755 $(NAME) ~/.local/bin/

.PHONY: uninstall
uninstall:
	rm ~/.local/bin/$(NAME)

.PHONY: proto
proto:
	protoc person.proto --cpp_out=.

-include $(DEPS)

