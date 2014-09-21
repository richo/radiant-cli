CFLAGS = -Wall -pedantic -Wextra
# -framework Cocoa -framework ScriptingBridge

radiant: src/radiant.rs src/libradiant.a
	rustc -L src -o $@ $<

src/libradiant.a: src/libradiant.o
	ar -r $@ $^

src/libradiant.o: src/radiant.m
	clang -c -o $@ $(CFLAGS) $<

clean:
	rm radiant src/libradiant.o src/libradiant.a

.PHONY: clean
