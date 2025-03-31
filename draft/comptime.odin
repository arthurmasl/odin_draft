package main

import "core:fmt"
import "core:time"

main :: proc() {
  t1 := time.now()
  fmt.println(len(comp_gen(10000)))
  fmt.println(time.since(t1))

}

comp_gen :: proc($N: int) -> [N]i32 {
  res: [N]i32

  for _, i in res {
    res[i] = 11
  }

  return res
}
