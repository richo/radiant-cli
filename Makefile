CFLAGS = -framework Cocoa -framework ScriptingBridge

radiant: src/radiant.m
	clang -o $@ $(CFLAGS) $<
