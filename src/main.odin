package main

import "core:fmt"
import rl "vendor:raylib"

Names :: enum {
  Bob,
  Josef,
  Carl,
}

names: map[Names]int = {
  .Bob   = 10,
  .Josef = 12,
  .Carl  = 22,
}

main :: proc() {
  random_name := Names{}

}
