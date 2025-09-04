package main

import "core:fmt"

CAPACITY :: 10

Entity_Id :: distinct int

Entity :: struct {}

Position :: struct {
  x, y: f32,
}

Velocity :: struct {
  x, y: f32,
}

World :: struct {
  positions:  [CAPACITY]Position,
  velocities: [CAPACITY]Velocity,
}

w: World

component_add :: proc(pool: ^[]$E, id: Entity_Id, component: E) {
}

main :: proc() {

}
