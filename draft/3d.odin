package main

import "core:fmt"
import "core:math"
import rl "vendor:raylib"

COUNT :: 300
RANGE :: 200

debug := true
spin := false

width := i32(1280)
height := i32(1412)
camera: rl.Camera3D
center: rl.Vector2
size := rl.Vector3{2, 2, 2}

Terrain :: struct {
  pos:  rl.Vector3,
  size: rl.Vector3,
}

terrain: [COUNT]Terrain

Player :: struct {
  pos:      rl.Vector3,
  acc:      rl.Vector3,
  vel:      rl.Vector3,
  friction: f32,
  speed:    f32,
  angle:    f32,
}

player: Player

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

  player.speed = 20
  player.friction = 0.9
  player.pos.y = 1

  init()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

}

init :: proc() {
  for &terrain in terrain {
    height := f32(rl.GetRandomValue(5, 15))

    terrain.pos = {
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

  player.acc = {}
  if rl.IsKeyDown(.E) do player.acc.z -= 1
  if rl.IsKeyDown(.D) do player.acc.z += 1
  if rl.IsKeyDown(.S) do player.acc.x -= 1
  if rl.IsKeyDown(.F) do player.acc.x += 1

  if rl.IsKeyDown(.SPACE) do player.acc.y += 1
  if rl.IsKeyDown(.LEFT_CONTROL) do player.acc.y -= 1

  if player.acc != 0 do player.acc = rl.Vector3Normalize(player.acc)

  player.vel *= (1 - player.friction)
  player.vel += player.acc * player.speed

  player.pos += player.vel * rl.GetFrameTime()
  player.angle = -rl.Vector2LineAngle(center, rl.GetMousePosition())

  camera.target = player.pos
  camera.position = {player.pos.x, player.pos.y + 40, player.pos.z + 50}

  if spin do rl.UpdateCamera(&camera, .ORBITAL)

  // direction.x = cosine(yaw angle of camera in radians) * speed
  // direction.y = sine(yaw angle of camera in radians) * speed
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.SKYBLUE)
  rl.BeginMode3D(camera)

  rl.DrawPlane({}, 500, rl.DARKGREEN)

  rl.DrawCubeV(player.pos, size, rl.MAROON)
  if debug do rl.DrawCubeWiresV(player.pos, size, rl.BLACK)

  for &terrain in terrain {
    rl.DrawCubeV(terrain.pos, terrain.size, rl.GRAY)
    if debug do rl.DrawCubeWiresV(terrain.pos, terrain.size, rl.BLACK)
  }

  if debug do rl.DrawGrid(100, 5)

  rl.EndMode3D()

  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}
