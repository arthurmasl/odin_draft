package main

import "core:fmt"
import "core:slice"

// val: $T
generic_proc_1 :: proc(a: $T) -> T {
  return a + 1
}

// $T: typeid
generic_proc_2 :: proc($T: typeid) -> T {
  return T(10)
}

// $N: int
generic_proc_3 :: proc($N: int) -> []int {
  arr: [N]int
  return slice.clone(arr[:])
}

// $N: $I
generic_proc_4 :: proc($N: $I) -> []I {
  arr: [N]I
  return slice.clone(arr[:])
}

// $T/[]$E
generic_proc_5 :: proc(array: $T/[]$E) -> (T, E) {
  fmt.println(size_of(T), size_of(E))
  return array, array[0]
}

// $T: typeid/[]$E
generic_proc_6 :: proc($T: typeid/[]$E) -> T {
  return make(T, 10)
}

main :: proc() {
  g1 := generic_proc_1(10)
  fmt.println(g1)

  g2 := generic_proc_2(u8)
  fmt.println(g2, typeid_of(type_of(g2)))

  g3 := generic_proc_3(5)
  fmt.println(g3, len(g3))

  g4 := generic_proc_4(u8(5))
  fmt.println(g4, len(g4), typeid_of(type_of(g4)))

  g5, g5_i := generic_proc_5([]u8{1, 2, 3})
  fmt.println(g5, g5_i)

  g6 := generic_proc_6([]u8)
  fmt.println(g6, typeid_of(type_of(g6)))
}
