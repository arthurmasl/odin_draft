package main

import pq "core:container/priority_queue"
import "core:fmt"

main :: proc() {
  less :: proc(a, b: int) -> bool {
    return a < b
  }

  q: pq.Priority_Queue(int)
  pq.init(&q, less, pq.default_swap_proc(int))

  pq.push(&q, 50)
  pq.push(&q, 10)
  pq.push(&q, 30)
  pq.push(&q, 5)

  fmt.println(pq.pop(&q))
  fmt.println(pq.pop(&q))
  fmt.println(pq.pop(&q))
  fmt.println(pq.pop(&q))

  // fmt.println(pq.peek(q))
}
