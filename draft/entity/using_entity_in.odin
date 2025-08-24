package main

import "core:fmt"

Entity :: struct {
  id:  u8,
  pos: [2]f64,
}

Player :: struct {
  using entity: Entity,
  hp:           u8,
}

Monster :: struct {
  using entity: Entity,
  is_agro:      bool,
}

main :: proc() {
  player := Player {
    id = 0,
    hp = 100,
  }
  monster := Monster {
    id = 1,
  }

  fmt.println(player)
  update_player(&player)
  update_pos(&player)
  fmt.println(player)

  fmt.println(monster)
  update_monster(&monster)
  update_pos(&monster)
  fmt.println(monster)
}

update_player :: proc(player: ^Player) {
  player.hp -= 10
}

update_monster :: proc(monster: ^Monster) {
  monster.is_agro = true
}

update_pos :: proc(entity: ^Entity) {
  entity.pos += 1
}
