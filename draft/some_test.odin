package main

import "core:fmt"
import "core:testing"

Error :: enum {
  None,
  Error,
}

get_error :: proc(fail: bool) -> Error {
  if fail do return .Error
  return .None
}

@(test)
succ :: proc(t: ^testing.T) {
  err := get_error(false)
  testing.expect(t, err != .Error)
}

@(test)
fail :: proc(t: ^testing.T) {
  err := get_error(true)
  testing.expect(t, err != .Error)
}
