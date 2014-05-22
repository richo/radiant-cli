/*
 * Radiant.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class RadiantApplication;



/*
 * Standard Suite
 */

@interface RadiantApplication : SBApplication

- (void) backTrack;  // reposition to beginning of current track or go to previous track if already at start of current track
- (void) nextTrack;  // advance to the next track in the current playlist
- (void) playpause;  // toggle the playing/paused state of the current track
- (void) toggleThumbsUp;  // toggle thumbs up for current track
- (void) toggleThumbsDown;  // toggle thumbs down for current track
- (void) toggleShuffle;  // toggle shuffle on/off
- (void) toggleRepeatmode;  // toggle repeat mode
- (void) toggleVisualization;  // toggle visualization on/off

@end

