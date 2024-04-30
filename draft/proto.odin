package main

import "core:fmt"
import "core:slice"

Collider :: struct {
  size: int,
}

Entity :: struct($Body: typeid) {
  using body: Body,
  pos:        int,
  name:       string,
}

Player :: struct {
  hp:             int,
  using collider: Collider,
}
Creature :: struct {
  hp:             int,
  count:          int,
  using collider: Collider,
}
Projectile :: struct {
  speed: int,
}

update_collider :: proc(entity: ^$T/Entity) {
  entity.collider.size = 555
}

update_entity :: proc(entity: ^$T/Entity) {
  entity.pos = 111
}

main :: proc() {
  player := Entity(Player) {
    name = "player",
    pos = 0,
    body = {hp = 100, collider = {50}},
  }
  creature := Entity(Creature) {
    name = "creature",
    pos = 0,
    body = {hp = 100, count = 1, collider = {40}},
  }
  projectile := Entity(Projectile) {
    name = "projectile",
    pos = 0,
    body = {speed = 52},
  }

  update_collider(&player)

  update_entity(&player)
  update_entity(&creature)
  update_entity(&projectile)
  // update_collider(&creature)
  // update_collider(&projectile)

  fmt.println(player)
  fmt.println(creature)
  fmt.println(projectile)
}
