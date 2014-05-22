#include <stdio.h>
#include <string.h>
#include <Cocoa/Cocoa.h>
#include "Radiant.h"

enum Action {
    next,
    prev,
    playpause,
    thumbsup,
    thumbsdown,
    shuffle,
    repeat,
    NONE
};

int main(int argc, char** argv) {
    id Radiant = [SBApplication applicationWithBundleIdentifier:@"com.sajidanwar.Radiant-Player"];
    enum Action action = NONE;
    if (argc == 1) {
        printf("Usage: %s <next|prev|playpause|thumbsup|thumbsdown|shuffle|repeat>\n", argv[0]);
        exit(1);
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
            exit(1);
    }
    return 0;
}
