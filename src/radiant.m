#include <stdio.h>
#include <string.h>
#include <Cocoa/Cocoa.h>
#include "Radiant.h"

enum Action {
    next = 'n',
    prev = 'p',
    playpause = '=',
    thumbsup = '+',
    thumbsdown = '-',
    shuffle = 's',
    repeat = 'r',
    NONE
};

int perform_action(id Radiant, enum Action);

int handle_stdin(id Radiant) {
    char i;
    while (read(1, &i, 1)) {
        perform_action(Radiant, (enum Action)i);
    }
    return 0;
}

static char* app_name;
void usage(int status) {
    dprintf(status + 1, "Usage: %s --stdin | <ACTION>\n", app_name);
    dprintf(status + 1, "ACTIONS: next, prev, playpause, thumbsup, thumbsdown, shuffle, repeat\n");
    exit(status);
}

int main(int argc, char** argv) {
    app_name = argv[0];
    id Radiant = [SBApplication applicationWithBundleIdentifier:@"com.sajidanwar.Radiant-Player"];
    enum Action action = NONE;
    if (argc == 1) {
        usage(1);
    }

    if (strcmp(argv[1], "--stdin") == 0) {
        return handle_stdin(Radiant);
    }

    if (strcmp(argv[1], "--help") == 0) {
        usage(0);
    }

#define ACTION(name) do { \
    if (strcmp(argv[1], #name) == 0) { \
        action = name; \
    } } while(0)

    ACTION(next);
    ACTION(prev);
    ACTION(playpause);
    ACTION(thumbsup);
    ACTION(thumbsdown);
    ACTION(shuffle);
    ACTION(repeat);

#undef ACTION

    if (perform_action(Radiant, action) > 0) {
        usage(1);
    }

    return 0;
}

int perform_action(id Radiant, enum Action action) {
    switch (action) {
        case next:
            [Radiant nextTrack]; break;
        case prev:
            [Radiant backTrack]; break;
        case playpause:
            [Radiant playpause]; break;
        case thumbsup:
            [Radiant toggleThumbsUp]; break;
        case thumbsdown:
            [Radiant toggleThumbsDown]; break;
        case shuffle:
            [Radiant toggleShuffle]; break;
        case repeat:
            [Radiant toggleRepeatmode]; break;
        default:
            return 1;
    }
    return 0;
}
