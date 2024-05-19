package main

import "core:fmt"
import "core:time"

SIZE :: 300000000

Variants :: enum {
  Creature,
  Projectile,
}

Entity :: struct {
  pos:     [2]f32,
  vel:     [2]f32,
  hp:      i32,
  speed:   f32,
  variant: Variants,
}

entities := make_soa(#soa[]Entity, SIZE)

main :: proc() {
  t1 := time.now()
  for &entity, i in entities {
    entity.variant = i % 2 == 0 ? .Projectile : .Creature
  }
  fmt.println(time.since(t1))

}
