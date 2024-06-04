package main

import "core:fmt"
import "core:time"

Vector :: struct {
  x, y: int,
}

sum_v :: proc(v: ^Vector) -> int {
  return v.x + v.y
}

vectors: [10000000]Vector

main :: proc() {
  t1 := time.now()
  sum := 0

  for &v, i in vectors {
    v.x = i
    sum += sum_v(&v)
  }

  fmt.println(sum)
  fmt.println(time.since(t1))

  s1 := [3]int{1, 2, 3}
  s2 := [3]int{1, 2, 3}

  fmt.println(s1 == s2)
}
