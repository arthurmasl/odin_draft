package main

import "core:fmt"

Entity_Id :: distinct int

Position :: struct {
  x, y: f32,
}
Velocity :: struct {
  vx, vy: f32,
}

Component_Pool :: struct(T: typeid) {
  sparse: []Entity_Id,
  dense:  []Entity_Id,
  count:  int,
  data:   []T,
}

pool_init :: proc($T: typeid, capacity: int) -> Component_Pool(T) {
  return Component_Pool(T) {
    sparse = make([]Entity_Id, capacity),
    dense = make([]Entity_Id, capacity),
    data = make([]T, capacity),
  }
}

pool_contains :: proc(pool: ^Component_Pool($T), id: Entity_Id) -> bool {
  if int(id) >= len(pool.sparse) do return false
  idx := int(pool.sparse[id])
  return idx < pool.count && pool.dense[idx] == id
}

pool_add :: proc(pool: ^Component_Pool($T), id: Entity_Id, value: T) {
  if pool_contains(pool, id) do return
  pool.dense[pool.count] = id
  pool.sparse[id] = Entity_Id(pool.count)
  pool.count += 1
  pool.data[id] = value
}

pool_has :: proc(pool: ^Component_Pool($T), id: Entity_Id) -> bool {
  if id >= len(pool.sparse) do return false
  idx := pool.sparse[id]
  return idx < pool.count && pool.dense[idx] == id
}

pool_get_ids :: proc(pool: ^Component_Pool($T)) -> []Entity_Id {
  return pool.dense[:pool.count]
}

pool_get :: proc(pool: ^Component_Pool($T), id: Entity_Id) -> ^T {
  return &pool.data[id]
}

iterate_pool :: proc(pool: ^Component_Pool($T)) {
  for id in pool_get_ids(pool) {
    pos := pool_get(pool, id)
    fmt.println(pos)
  }
}

main :: proc() {
  capacity := 3
  positions := pool_init(Position, capacity)
  velocities := pool_init(Velocity, capacity)

  e1 := Entity_Id(1)
  e2 := Entity_Id(2)

  pool_add(&positions, e1, Position{10, 10})
  pool_add(&velocities, e1, Velocity{1, 1})

  pool_add(&positions, e2, Position{5, 5})

  iterate_pool(&positions)
  fmt.println()
  iterate_pool(&velocities)

  // fmt.printfln("%#v", positions)
}
