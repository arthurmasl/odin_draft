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

component_set :: proc(id: Entity_Id, array: ^#soa[]$E, component: E) {
  array[id] = component
}

position_system :: proc() {
  for &e in g.movement {
    e.vel = 10
    e.pos += e.vel
  }
}

main :: proc() {
  game_init(capacity = 2)

  g.stats[Entity_Id.Player] = {
    hp     = 100,
    max_hp = 150,
  }
  g.movement[Entity_Id.Player] = {
    pos = 5,
    vel = 1,
  }
  component_set(.Player, &g.stats, Stats_Component{hp = 100, max_hp = 150})
  component_set(.Player, &g.movement, Movement_Coponent{pos = 5, vel = 1})
  component_set(.Player, &g.flags, Flags_Component{.Alive})

  component_set(.Enemy, &g.stats, Stats_Component{hp = 0, max_hp = 100})
  component_set(.Enemy, &g.flags, Flags_Component{.Dead})

  // position_system()

  fmt.println(g.stats[Entity_Id.Player])
  fmt.println(g.movement[Entity_Id.Player])
  fmt.println(g.flags[Entity_Id.Player])

  fmt.println()
  fmt.println(g.stats[Entity_Id.Enemy])
  fmt.println(g.movement[Entity_Id.Enemy])
  fmt.println(g.flags[Entity_Id.Enemy])
}
