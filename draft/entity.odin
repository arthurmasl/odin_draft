package main

import "core:fmt"
import "core:log"
import "core:mem"
import "core:mem/virtual"
import "core:slice"

Entity :: struct {
  variant: union {
    Player,
    Creature,
  },
  pos:     i32,
}

Player :: struct {
  using entity: ^Entity,
  hp:           i32,
}

Creature :: struct {
  using entity: ^Entity,
  count:        i32,
}

create_entity :: proc($T: typeid) -> ^Entity {
  t := new(Entity)
  t.variant = T {
    entity = t,
  }
  return t
}

update_entity :: proc(entity: ^Entity) {
  switch &variant in entity.variant {
  case Player:
    update_player(&variant)
  case Creature:
    update_creature(&variant)
  }
}

update_player :: proc(player: ^Player) {
  player.hp = 522
  player.pos = 311
}

update_creature :: proc(creature: ^Creature) {
  creature.count = 333
  creature.pos = 551

  if entity.variant.(^Creature) || entity.variant.(^Player) {
    fmt.println(entity.variant)
  }
}

main :: proc() {
  player = create_entity(Player)
  creature := create_entity(Creature)

  player.entities := make([dynamic]^Entity)
  append(&entities, player)
  append(&entities, creature)

  for entity in entities {
    update_entity(entity)

    fmt.println(entity)
  }
}
