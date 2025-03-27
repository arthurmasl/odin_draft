package main

import "core:fmt"

Direction :: enum {
  North,
  East,
  South,
  West,
}

DirectionSet :: bit_set[Direction]

main :: proc() {
  dir1 := DirectionSet{.North}
  dir2 := DirectionSet{.East, .North}

  fmt.println(dir1, dir2)
  fmt.println(dir1 ~ dir2)
  fmt.println(dir1 | dir2)
}
