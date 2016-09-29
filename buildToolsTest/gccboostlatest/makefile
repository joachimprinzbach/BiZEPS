CFLAGS  = -g -Wall
#CC=gcc
LIBS=-lboost_unit_test_framework

# the build target executable:
TARGET = test

all: $(TARGET)

%.o: %.cpp
	$(CXX) $(CFLAGS) -c -o $@ $<

$(TARGET): test_main.o
	$(CXX) -o $@ $^ $(LIBS)

clean:
	$(RM) $(TARGET)

runtest: $(TARGET)
	./$(TARGET)