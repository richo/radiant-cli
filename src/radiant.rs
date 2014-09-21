extern crate libc;

use std::os;
use std::io;
use std::string::String;

#[repr(C)]
enum Action {
    Next,
    Prev,
    PlayPause,
    ThumbsUp,
    ThumbsDown,
    Shuffle,
    Repeat
}

#[link(name = "ScriptingBridge", kind = "framework")]
#[link(name = "Cocoa", kind = "framework")]
#[link(name = "src/radiant.o", kind = "static")]
extern "C" {
    fn init_radiant() -> libc::c_int;
    fn perform_action(action: Action) -> libc::c_int;
}

fn wrap_action(action: Action) {
    unsafe { perform_action(action); }
}

fn usage() {
    println!("Usage: {} --stdin | <ACTION>\n", os::args().get(0));
    println!("ACTIONS: next, prev, playpause, thumbsup, thumbsdown, shuffle, repeat\n");
}

fn handle_stdin() {
    let mut stdin = io::stdin();
    loop {
        match stdin.read_char() {
            Ok('n') => wrap_action(Next),
            Ok('p') => wrap_action(Prev),
            Ok('=') => wrap_action(PlayPause),
            Ok('+') => wrap_action(ThumbsUp),
            Ok('-') => wrap_action(ThumbsDown),
            Ok('s') => wrap_action(Shuffle),
            Ok('r') => wrap_action(Repeat),
            Ok(_) => {},
            Err(_) => return
        }
    }
}

fn handle_arg(arg: &String) {
    if unsafe { init_radiant() } != 1 {
        fail!("Couldn't init radiant");
    }

    match arg.as_slice() {
        "--stdin" => handle_stdin(),
        "next" => wrap_action(Next),
        "prev" => wrap_action(Prev),
        "playpause" => wrap_action(PlayPause),
        "thumbsup" => wrap_action(ThumbsUp),
        "thumbsdown" => wrap_action(ThumbsDown),
        "shuffle" => wrap_action(Shuffle),
        "repeat" => wrap_action(Repeat),
        _ => usage(),
    }
}

fn main() {
    match os::args().len() {
        2 => handle_arg(&os::args()[1]),
        _ => usage(),
    }
}
