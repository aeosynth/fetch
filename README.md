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

| language | LOC |
| - | - |
| bash | 27 |
| python | 33 |
| janet | 35 |
| deno | 36 |
| lua | 38 |
| rust | 66 |

note that the lua script is incomplete as lua cannot natively list a directory's files

the deno script must be run with `deno run --allow-env --allow-read deno.js`

i'm bad at every language btw
