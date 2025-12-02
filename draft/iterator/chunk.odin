package main

import "core:fmt"

Chunk_Iterator :: struct($T: typeid) {
  slice: T,
  size:  int,
  index: int,
}

chunk_iterator :: proc($T: typeid, it: ^Chunk_Iterator(T)) -> (chunk: T, ok: bool) {
  if it.index >= len(it.slice) {
    when T == string do return "", false
    when T != string do return nil, false
  }

  end := min(it.index + it.size, len(it.slice))
  chunk = it.slice[it.index:end]

  it.index = end

  return chunk, true
}

main :: proc() {
  {
    data := []int{1, 2, 3, 4, 5, 6}

    it := Chunk_Iterator([]int) {
      slice = data,
      size  = 2,
    }

    for val in chunk_iterator([]int, &it) {
      fmt.println(val)
    }
  }

  {
    data := "121212"

    it := Chunk_Iterator(string) {
      slice = data,
      size  = 2,
    }

    for val in chunk_iterator(string, &it) {
      fmt.println(val)
    }
  }

  {
    data := []string{"a", "b", "c", "d"}

    it := Chunk_Iterator([]string) {
      slice = data,
      size  = 2,
    }

    for val in chunk_iterator([]string, &it) {
      fmt.println(val)
    }
  }
}
