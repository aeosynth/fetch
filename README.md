# fetch
a polyglot repo showing system status fetching in different languages. the output will look something like this:

```
james@void
kernel	5.4.46_1
term	alacritty
shell	/bin/sh
tasks	151
mem	2559m / 3974m
uptime	0d 16h 39m
```

| language | sloc |
| - | - |
| crystal | 17 |
| raku | 17 |
| ruby | 17 |
| julia | 19 |
| deno | 20 |
| kotlin | 20 |
| node | 20 |
| python | 21 |
| r | 21 |
| janet | 22 |
| bash | 23 |
| nim | 25 |
| sh | 25 |
| csharp | 30 |
| go | 46 |
| rust | 61 |

the deno script must be run with `deno run --allow-env --allow-read deno.js`

for most languages the code size is determined by use of imports, and whether a `main` function is needed

# spec

try to follow an existing program for code organization

external programs must not be used

files must be closed after read (most languages do this automatically)

the output must be in a single command. there must not be any code besides string interpolation / concatenation, ie define all variables beforehand.

if an official style formatter exists it must be used

the readme table is sorted by sloc
