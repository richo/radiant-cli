CFLAGS = -Wall -pedantic -Wextra
# -framework Cocoa -framework ScriptingBridge

radiant: src/radiant.rs src/radiant.o
	rustc -o $@ $<

src/radiant.o: src/radiant.m
	clang -c -o $@ $(CFLAGS) $<

clean:
	rm radiant src/radiant.o

.PHONY: clean
