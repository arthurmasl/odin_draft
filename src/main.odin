package main

import "core:fmt"
import "core:os"
import "core:thread"

main :: proc() {
  t1 := thread.create_and_start(proc() {
    sum: i32
    for i in 0 ..< 100000 {
      sum += 1
    }

    fmt.println("t1", sum)
  })

  t2 := thread.create_and_start(proc() {
    sum: i32
    for i in 0 ..< 100000 {
      sum += 1
    }

    fmt.println("t2", sum)
  })

  for {
    t1_done := thread.is_done(t1)
    t2_done := thread.is_done(t2)

    if t1_done do thread.terminate(t1, 0)
    if t2_done do thread.terminate(t2, 0)

    if t1_done && t2_done do break
  }

  fmt.println("done")
}
