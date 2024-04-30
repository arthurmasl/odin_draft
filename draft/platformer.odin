package main

import "core:fmt"
import rl "vendor:raylib"

pos: rl.Vector2
vel: rl.Vector2
ground: f32
grounded := true

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE})
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_UNFOCUSED})

  rl.InitWindow(1000, 0, "demo")
  defer rl.CloseWindow()

  rl.SetWindowPosition(0, 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0))

  init()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }
}

init :: proc() {
  pos = rl.Vector2{f32(rl.GetScreenWidth()) / 2, f32(rl.GetScreenHeight() / 2)}
  ground = f32(rl.GetScreenHeight() - 200)
}

update :: proc() {
  if rl.IsKeyDown(.A) do vel.x = -400
  else if rl.IsKeyDown(.D) do vel.x = 400
  else do vel.x = 0

  vel.y += 2000 * rl.GetFrameTime()

  if grounded && rl.IsKeyPressed(.W) {
    grounded = false
    vel.y = -600
  }

  pos += vel * rl.GetFrameTime()

  if pos.y > ground {
    grounded = true
    pos.y = ground
  }

}

draw :: proc() {
  rl.BeginDrawing()
  rl.DrawFPS(10, 10)
  defer rl.EndDrawing()

  rl.ClearBackground(rl.BLACK)
  rl.DrawCircleV(pos, 50, rl.RED)
  rl.DrawRectangle(0, i32(ground) + 50, rl.GetScreenWidth(), 150, rl.GRAY)
}
