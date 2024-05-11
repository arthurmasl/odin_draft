package main

import "core:fmt"

Subject :: struct {
  name:      string,
  observers: [dynamic]^Observer,
  subscribe: type_of(subscribe),
  notify:    type_of(notify),
}

create_subject :: proc(name: string) -> Subject {
  return Subject{name = name, subscribe = subscribe, notify = notify}
}

subscribe :: proc(subject: ^Subject, observer: ^Observer) {
  append(&subject.observers, observer)
}

notify :: proc(subject: ^Subject) {
  fmt.println("update", subject.name)
  for observer in subject.observers {
    observer->update()
  }
}

Observer :: struct {
  name:   string,
  update: type_of(update),
}

create_observer :: proc(name: string) -> Observer {
  return Observer{name = name, update = update}
}

update :: proc(observer: ^Observer) {
  fmt.println("update", observer.name)
}

main :: proc() {
  player := create_subject("player")

  ui := create_observer("ui")
  audio := create_observer("audio")

  player->subscribe(&ui)
  player->subscribe(&audio)

  player->notify()

}
