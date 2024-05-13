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

LIB_PATH :: "build/lib.dylib"

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
    update_hot()
  }
}

update_hot :: proc() {
  // mod_time, mod_err := os.last_write_time_by_name(LIB_PATH)
  // if mod_time != last_mod {
  //   last_mod = mod_time

    // if last_lib != nil do dynlib.unload_library(last_lib)
    //
    // lib, lib_loaded := dynlib.load_library(LIB_PATH)
    // if lib_loaded {
    //   fmt.println("lib loaded")
    //   last_lib = lib
    //
    //   update_address, found_address := dynlib.symbol_address(lib, "update")
    //   if found_address {
    //     fmt.println("found update address", update_address)
    //   }
    // }
  // }
}
