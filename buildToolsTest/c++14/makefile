CFLAGS  = -g -Wall -std=c++14
#CC=gcc

# the build target executable:
TARGET = test

all: $(TARGET)

%.o: %.cpp
	$(CXX) $(CFLAGS) -c -o $@ $<

$(TARGET): main.o
	$(CXX) -o $@ $^

clean:
	$(RM) $(TARGET)

runtest: $(TARGET)
	./$(TARGET)