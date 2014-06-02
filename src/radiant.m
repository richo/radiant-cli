#include "Radiant.h"

enum Action {
    next,
    prev,
    playpause,
    thumbsup,
    thumbsdown,
    shuffle,
    repeat
};

static id Radiant;
int init_radiant(void) {
    Radiant = [SBApplication applicationWithBundleIdentifier:@"com.sajidanwar.Radiant-Player"];
    return (Radiant != NULL);
}

int perform_action(enum Action action) {
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
