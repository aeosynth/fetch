use std::env::var;
use std::fs::{read_dir, read_to_string};

fn mem() -> (i32, i32) {
    let mem = read_to_string("/proc/meminfo").unwrap();
    let get = |i: usize| -> i32 {
        mem.lines()
            .nth(i)
            .unwrap()
            .split_ascii_whitespace()
            .nth(1)
            .unwrap()
            .parse::<i32>()
            .unwrap()
            / 1000
    };
    (get(0), get(2))
}

fn uptime() -> (i32, i32, i32) {
    let uptime = read_to_string("/proc/uptime")
        .unwrap()
        .split(' ')
        .next()
        .unwrap()
        .parse::<f64>()
        .unwrap() as i32;
    let d = uptime / 60 / 60 / 24;
    let h = uptime / 60 / 60 % 24;
    let m = uptime / 60 % 60;
    (d, h, m)
}

fn main() {
    let user = var("USER").unwrap();
    let host = read_to_string("/etc/hostname").unwrap().trim().to_string();
    let kernel = read_to_string("/proc/version")
        .unwrap()
        .split(' ')
        .nth(2)
        .unwrap()
        .to_string();
    let term = var("TERM").unwrap();
    let shell = var("SHELL").unwrap();

    let tasks = read_dir("/proc")
        .unwrap()
        .filter(|entry| {
            let name = entry.as_ref().unwrap().file_name().into_string().unwrap();
            name.chars().all(|c| c.is_digit(10))
        })
        .count();

    let (total, avail) = mem();
    let (d, h, m) = uptime();
    println!(
        "{}@{}
kernel\t{}
term\t{}
shell\t{}
tasks\t{}
mem\t{}m / {}m
uptime\t{}d {}h {}m",
        user, host, kernel, term, shell, tasks, avail, total, d, h, m
    );
}
