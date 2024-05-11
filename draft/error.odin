package main

import "core:fmt"

Error :: enum {
  None,
  Error,
}

render_texture :: proc(name: string) -> (error: Error) {
  if name != "good" do return .Error
  fmt.println("render texture")
  return .None
}

main :: proc() {
  if err := render_texture("good2"); err != nil {
    fmt.println("err")
  }

}
