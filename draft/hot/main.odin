package main
import rl "vendor:raylib"

import "core:fmt"

main :: proc() {
  fmt.println("lib loaded")
}

@(export)
update :: proc() {
  // rl.DrawRectangleV({0, 0}, 50, rl.RED)
}
