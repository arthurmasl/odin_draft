package main

import rl "vendor:raylib"

width: f32
height: f32
camera: rl.Camera2D
center: rl.Vector2

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
    update()
    draw()
  }
}

update :: proc() {

}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)
  rl.BeginMode2D(camera)

  rl.EndMode2D()
  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}
