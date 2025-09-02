package main

import "core:fmt"

CAPACITY :: 2

Entity_Id :: distinct uint

Movement_Coponent :: struct {
  pos: f32,
  vel: f32,
}

Stats_Component :: struct {
  hp:     f32,
  max_hp: f32,
}

Flags_Component :: struct {
  state: enum u8 {
    Alive,
    Dead,
  },
}

Renderable_Object :: struct {
  id:   uint,
  data: rawptr,
}

Renderable_Component :: struct {
  pipeline: Renderable_Object,
  binding:  Renderable_Object,
}

Game :: struct {
  movement:   #soa[]Movement_Coponent,
  stats:      #soa[]Stats_Component,
  flags:      #soa[]Flags_Component,
  renderable: #soa[]Renderable_Component,
}

g: Game

entity_create :: proc() -> Entity_Id {
  @(static) id := Entity_Id(0)
  local_id := id
  id += 1
  return local_id
}

game_init :: proc() {
  g = {
    movement   = make(#soa[]Movement_Coponent, CAPACITY),
    stats      = make(#soa[]Stats_Component, CAPACITY),
    flags      = make(#soa[]Flags_Component, CAPACITY),
    renderable = make(#soa[]Renderable_Component, CAPACITY),
  }
}

component_set :: proc(id: Entity_Id, array: ^#soa[]$E, component: E) {
  array[id] = component
}

movement_system :: proc() {
  for &e in g.movement {
    e.pos += e.vel
  }
}

renderable_system :: proc() {
  for &e in g.renderable {
    fmt.println("use bindings with id", e.binding.id)
    fmt.println("use pipeline with id", e.pipeline.id)
  }
}

main :: proc() {
  game_init()

  player := entity_create()
  component_set(player, &g.stats, Stats_Component{hp = 100, max_hp = 150})
  component_set(player, &g.movement, Movement_Coponent{pos = 5, vel = 1})
  component_set(player, &g.flags, Flags_Component{.Alive})
  component_set(player, &g.renderable, Renderable_Component{pipeline = {id = 111}, binding = {id = 111}})

  enemy := entity_create()
  component_set(enemy, &g.stats, Stats_Component{hp = 0, max_hp = 100})
  component_set(enemy, &g.flags, Flags_Component{.Dead})
  component_set(enemy, &g.renderable, Renderable_Component{pipeline = {id = 222}, binding = {id = 222}})

  movement_system()
  renderable_system()
}
