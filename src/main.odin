package main

import "core:fmt"

Entity_Id :: int

Sparse_Set :: struct {
  sparse: []Entity_Id,
  dense:  []Entity_Id,
  count:  int,
}

sparse_set_init :: proc(capacity: int) -> Sparse_Set {
  return {sparse = make([]Entity_Id, capacity), dense = make([]Entity_Id, capacity)}
}

sparse_set_contains :: proc(set: ^Sparse_Set, id: Entity_Id) -> bool {
  if id >= len(set.sparse) do return false
  idx := set.sparse[id]
  return idx < set.count && set.dense[idx] == id
}

sparse_set_insert :: proc(set: ^Sparse_Set, id: Entity_Id) {
  if sparse_set_contains(set, id) do return
  set.dense[set.count] = id
  set.sparse[id] = set.count
  set.count += 1
}

Position :: struct {
  x, y: f32,
}
Velocity :: struct {
  vx, vy: f32,
}

Component_Pool :: struct(T: typeid) {
  set:  Sparse_Set,
  data: []T,
}

pool_init :: proc($T: typeid, capacity: int) -> Component_Pool(T) {
  return {set = sparse_set_init(capacity), data = make([]T, capacity)}
}

pool_add :: proc(pool: ^Component_Pool($T), id: Entity_Id, value: T) {
  sparse_set_insert(&pool.set, id)
  pool.data[id] = value
}

pool_has :: proc(pool: ^Component_Pool($T), id: Entity_Id) -> bool {
  return sparse_set_contains(&pool.set, id)
}

pool_get :: proc(pool: ^Component_Pool($T), id: Entity_Id) -> ^T {
  return &pool.data[id]
}

iterate_pool :: proc(pool: ^Component_Pool($T)) {
  for id in pool.set.dense[:pool.set.count] {
    pos := pool.data[id]
    fmt.println(pos)
  }
}

main :: proc() {
  capacity := 3
  positions := pool_init(Position, capacity)
  velocities := pool_init(Velocity, capacity)

  e1 := 1
  e2 := 2

  pool_add(&positions, e1, Position{10, 10})
  pool_add(&velocities, e1, Velocity{1, 1})

  pool_add(&positions, e2, Position{5, 5})

  iterate_pool(&positions)
  fmt.println()
  iterate_pool(&velocities)
}
