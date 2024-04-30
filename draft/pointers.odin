package main

import "core:fmt"
import "core:slice"

Vector2 :: struct {
  x: i32,
  y: i32,
}

Collider :: struct {
  size: ^i32,
  pos:  ^Vector2,
  mix:  i32,
}

Player :: struct {
  pos:  Vector2,
  size: i32,
}

main :: proc() {
  player := Player {
    pos  = {0, 0},
    size = 10,
  }
  collider := Collider {
    size = &player.size,
    pos  = &player.pos,
  }

  player.pos.x = 55
  player.size = 200

  // fmt.println(player)
  // fmt.println(collider.size^)
  // fmt.println(collider.pos.x + collider.size^)
}
