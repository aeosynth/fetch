package main

import (
  "fmt"
  "io/ioutil"
  "os"
  "strconv"
  "strings"
)

func read(path string) string {
  buf, _ := ioutil.ReadFile(path)
  return string(buf)
}

func main() {
  user := os.Getenv("USER")
  host := read("/etc/hostname")
  kernel := strings.Fields(read("/proc/version"))[2]
  term := os.Getenv("TERM")
  shell := os.Getenv("SHELL")

  n := 0
  files, _ := ioutil.ReadDir("/proc")
  for _, file := range files {
    _, err := strconv.Atoi(file.Name())
    if err == nil {
      n += 1
    }
  }
  tasks := strconv.Itoa(n)

  mem := strings.Split(read("/proc/meminfo"), "\n")
  getSize := func(s string) string {
    i, _ := strconv.Atoi(strings.Fields(s)[1])
    return strconv.Itoa(i / 1000)
  }
  total := getSize(mem[0])
  avail := getSize(mem[2])

  uptime, _ := strconv.Atoi(strings.Split(read("/proc/uptime"), ".")[0])
  d := strconv.Itoa(uptime / 60 / 60 / 24)
  h := strconv.Itoa(uptime / 60 / 60 % 24)
  m := strconv.Itoa(uptime / 60 / 60)

  fmt.Printf(user + "@" + host +
"kernel\t" + kernel +
"\nterm\t" + term +
"\nshell\t" + shell +
"\ntasks\t" + tasks +
"\nmem\t" + avail + "m / " + total + "m" +
"\nuptime\t" + d + "d " + h + "h " + m + "m")
}
