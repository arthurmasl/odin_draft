package main

import "core:fmt"

Position_Id :: enum u8 {
  Player,
  Enemy,
  Particle,
}

Velocity_Id :: enum u8 {
  Player,
  Particle,
}

World :: struct {
  positions:  [Position_Id]f32,
  velocities: [Velocity_Id]f32,
}

w: World

main :: proc() {
  fmt.printfln("%#w", w)

  w.positions[.Player] = 10
  w.positions[.Enemy] = 50
  w.positions[.Particle] = 200

  w.velocities[.Player] = 1
  w.velocities[.Particle] = 5

  for &pos in w.positions {
    fmt.println(pos)
  }
}
