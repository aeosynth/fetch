(let [user (os/getenv "USER")
      host (slurp "/etc/hostname")
      kernel (->> (slurp "/proc/version") (string/split " ") 2)
      term (os/getenv "TERM")
      shell (os/getenv "SHELL")
      tasks (length (filter scan-number (os/dir "/proc")))
      mem (->> (slurp "/proc/meminfo") (string/split "\n") (take 3))
      uptime (->> (slurp "/proc/uptime") (string/split ".") 0 int/u64)]

  (defn split [s] (filter (comp not empty?) (string/split " " s)))
  (def mem (map (comp |(/ $ 1000) int/u64 1 split) mem))
  (def total (mem 0))
  (def avail (mem 2))

  (def d (-> uptime (/ 60 60 24)))
  (def h (-> uptime (/ 60 60) (% 24)))
  (def m (-> uptime (/ 60) (% 60)))

  (print user "@" host
"kernel\t" kernel
"\nterm\t" term
"\nshell\t" shell
"\ntasks\t" tasks
"\nmem\t" avail "m / " total "m"
"\nuptime\t" d "d " h "h " m "m"))
