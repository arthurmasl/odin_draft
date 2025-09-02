package main

import "core:fmt"

Entity :: distinct uint

Entity_Id :: enum u8 {
  Player,
  Enemy,
}

Movement_Coponent :: struct {
  pos: f32,
  vel: f32,
}

Stats_Component :: struct {
  hp:     f32,
  max_hp: f32,
}

Flags_State :: enum u8 {
  Alive,
  Dead,
}

Flags_Component :: struct {
  state: Flags_State,
}

Game :: struct {
  movement: #soa[]Movement_Coponent,
  stats:    #soa[]Stats_Component,
  flags:    #soa[]Flags_Component,
}

g: Game

game_init :: proc(capacity: int) {
  g = {
    movement = make(#soa[]Movement_Coponent, capacity),
    stats    = make(#soa[]Stats_Component, capacity),
    flags    = make(#soa[]Flags_Component, capacity),
  }
}

entity_create :: proc(id: Entity_Id) {
  g.movement[id].pos = 50
  g.stats[id].hp = 100
  g.stats[id].max_hp = 150
}

position_system :: proc() {
  for &e in g.movement {
    e.vel = 10
    e.pos += e.vel
  }
}

main :: proc() {
  game_init(capacity = 2)

  entity_create(id = .Player)
  entity_create(id = .Enemy)

  position_system()

  fmt.println(g.flags)
}
