(defn read [path]
  (let [f (file/open path)
        b (file/read f :all)]
    (file/close f)
    b))

(let [user (os/getenv "USER")
      host (read "/etc/hostname")
      kernel (->> (read "/proc/version") (string/split " ") 2)
      term (os/getenv "TERM")
      shell (os/getenv "SHELL")
      [total _ avail] (->> (read "/proc/meminfo") (string/split "\n"))
      uptime (->> (read "/proc/uptime") (string/split ".") 0 int/u64)]

  (var tasks 0)
  (each path (os/dir "/proc")
        (if (scan-number path)
          (++ tasks)))

  (defn matches [s] (peg/match '(some (+ (<- :d+) 1)) s))
  (def get-size (comp |(/ $ 1000) int/u64 0 |(matches $)))
  (def total (get-size total))
  (def avail (get-size avail))

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
