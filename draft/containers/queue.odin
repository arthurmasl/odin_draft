package main

import "core:container/queue"
import "core:fmt"

main :: proc() {
  q: queue.Queue(int)
  queue.init(&q)

  queue.push_back(&q, 1)
  queue.push_back(&q, 2)
  queue.push_front(&q, 102)

  // fmt.printfln("%#v", q)
  fmt.println(queue.pop_back(&q))
  fmt.println(queue.pop_back(&q))
  fmt.println(queue.pop_front(&q))
}
