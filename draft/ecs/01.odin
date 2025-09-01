package main

import "core:fmt"

Entity :: distinct uint

Entity_Id :: enum u8 {
  Player,
  Enemy,
}

Position_Coponent :: struct {
  pos: f32,
  vel: f32,
}

Healt_Component :: struct {
  hp:     f32,
  max_hp: f32,
}

Game :: struct {
  positions: #soa[]Position_Coponent,
  healths:   #soa[]Healt_Component,
}

g: Game

game_init :: proc(capacity: int) {
  g = {
    positions = make(#soa[]Position_Coponent, capacity),
    healths   = make(#soa[]Healt_Component, capacity),
  }
}

entity_create :: proc(id: Entity_Id) {
  g.positions[id].pos = 50
  g.healths[id].hp = 100
  g.healths[id].max_hp = 150
}

position_system :: proc() {
  for &p in g.positions {
    p.vel = 10
  }

  for &p in g.positions {
    p.pos += p.vel
  }
}

main :: proc() {
  game_init(capacity = 2)

  entity_create(id = .Player)
  entity_create(id = .Enemy)

  position_system()

  fmt.println(g.healths[Entity_Id.Player])
}
