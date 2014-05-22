CFLAGS = -framework Cocoa -framework ScriptingBridge -DHOME='"$(HOME)"'

radiant: src/radiant.m
	clang -o $@ $(CFLAGS) $<
