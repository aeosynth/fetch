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
| crystal | 21 |
| julia | 21 |
| ruby | 21 |
| janet | 22 |
| kotlin | 22 |
| bash | 23 |
| python | 25 |
| deno | 26 |
| nim | 26 |
| go | 46 |
| rust | 61 |

the deno script must be run with `deno run --allow-env --allow-read deno.js`

for most languages the code size is determined by use of imports and whether files are closed automatically after reading
