RC=rustc

# the build target executable:
TARGET = test

all: $(TARGET)

$(TARGET): main.rs
	$(RC) --crate-name $@ $<

clean:
	$(RM) $(TARGET)

runtest: $(TARGET)
	./$(TARGET)