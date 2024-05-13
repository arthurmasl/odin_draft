package main

import "core:fmt"
import rl "vendor:raylib"

COUNT :: 300
RANGE :: 200

debug := true
spin := true

width := i32(1280)
height := i32(1412)
camera: rl.Camera3D
center: rl.Vector2

pos := rl.Vector3{0, 1, 0}
size := rl.Vector3{2, 2, 2}

Terrain :: struct {
  pos:  rl.Vector3,
  size: rl.Vector3,
}

terrain: [COUNT]Terrain

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(width, height, "game prototype")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(1) * 3)

  width = rl.GetScreenWidth()
  height = rl.GetScreenHeight()

  center = {f32(width / 2), f32(height / 2)}
  camera = {
    position   = {0, 40, 50},
    target     = {0, 0, 0},
    up         = {0, 10, 0},
    fovy       = 45,
    projection = .PERSPECTIVE,
  }

  init()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

}

init :: proc() {
  for &terrain in terrain {
    height := f32(rl.GetRandomValue(5, 15))

    terrain.pos =  {
      f32(rl.GetRandomValue(-RANGE, RANGE)),
      height / 2,
      f32(rl.GetRandomValue(-RANGE, RANGE)),
    }
    terrain.size = {f32(rl.GetRandomValue(5, 15)), height, f32(rl.GetRandomValue(5, 15))}
  }
}

update :: proc() {
  if rl.IsKeyPressed(.U) do debug = !debug
  if rl.IsKeyPressed(.C) do spin = !spin

  if spin do rl.UpdateCamera(&camera, .ORBITAL)

}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.DARKGREEN)
  rl.BeginMode3D(camera)

  rl.DrawCubeV(pos, size, rl.MAROON)
  if debug do rl.DrawCubeWiresV(pos, size, rl.BLACK)

  for &terrain in terrain {
    rl.DrawCubeV(terrain.pos, terrain.size, rl.GRAY)
    if debug do rl.DrawCubeWiresV(terrain.pos, terrain.size, rl.BLACK)
  }

  if debug do rl.DrawGrid(100, 5)

  rl.EndMode3D()

  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}
