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

int main(int argc, char** argv) {
    id Radiant = [SBApplication applicationWithBundleIdentifier:@"com.sajidanwar.Radiant-Player"];
    enum Action action = NONE;
    if (argc == 1) {
        printf("Usage: %s <next|prev|playpause|thumbsup|thumbsdown|shuffle|repeat>\n", argv[0]);
        exit(1);
    }

    if (strcmp(argv[1], "--stdin") == 0) {
        return handle_stdin(Radiant);
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

    return perform_action(Radiant, action);
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
            printf("Unknown action\n");
            return 1;
    }
    return 0;
}
