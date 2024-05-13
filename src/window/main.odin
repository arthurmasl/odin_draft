package window

import "core:dynlib"
import "core:fmt"
import "core:os"
import rl "vendor:raylib"

width: f32
height: f32
camera: rl.Camera2D
center: rl.Vector2

last_mod: os.File_Time
last_lib: dynlib.Library

LIB_PATH :: "build/library.dylib"

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "game prototype")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0) * 3)

  width = f32(rl.GetScreenWidth())
  height = f32(rl.GetScreenHeight())

  center = {width / 2, height / 2}
  camera = {
    zoom   = 1,
    offset = center,
  }

  for !rl.WindowShouldClose() {
    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    update_hot()

    rl.DrawFPS(10, 10)
    rl.EndDrawing()
  }

  defer rl.CloseWindow()
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)
  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}

update_hot :: proc() {
  mod_time, mod_err := os.last_write_time_by_name(LIB_PATH)
  if mod_err != 0 do return
  if mod_time == last_mod do return

  last_mod = mod_time

  lib, lib_loaded := dynlib.load_library(LIB_PATH)
  if !lib_loaded do return
  if last_lib != nil do dynlib.unload_library(last_lib)

  last_lib = lib

  update_address, found_address := dynlib.symbol_address(last_lib, "update")
  if !found_address do return

  fmt.println("found update address", update_address)
  (cast(proc())update_address)()
}
