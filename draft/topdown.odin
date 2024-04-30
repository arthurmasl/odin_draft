package main

import "core:fmt"
import rl "vendor:raylib"

Player :: struct {
  vel:  rl.Vector2,
  pos:  rl.Vector2,
  rect: rl.Rectangle,
}

Enemy :: struct {
  pos:  rl.Vector2,
  rect: rl.Rectangle,
}

SIZE := rl.Vector2{50, 50}
SPEED: f32 = 25.0
FRICTION: f32 = 0.9

player: Player
camera: rl.Camera2D
enemies: [1000]Enemy

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
  camera = rl.Camera2D {
    offset = rl.Vector2{f32(rl.GetScreenWidth() / 2), f32(rl.GetScreenHeight() / 2)},
    target = player.pos,
    zoom   = 0.8,
  }

  for _, i in enemies {
    enemies[i].pos =  {
      f32(rl.GetRandomValue(-1500, 1500)),
      f32(rl.GetRandomValue(-1500, 1500)),
    }
  }
}

update :: proc() {
  if rl.IsKeyDown(.W) do player.vel.y -= SPEED
  if rl.IsKeyDown(.S) do player.vel.y += SPEED
  if rl.IsKeyDown(.D) do player.vel.x += SPEED
  if rl.IsKeyDown(.A) do player.vel.x -= SPEED

  player.vel *= FRICTION
  player.pos += player.vel * rl.GetFrameTime()
  player.rect = rl.Rectangle{player.pos.x, player.pos.y, 50, 50}

  for enemy, i in enemies {
    direction := player.pos - enemy.pos
    normalizedDirection := rl.Vector2Normalize(direction)

    mobVel := normalizedDirection * SPEED
    enemies[i].pos += mobVel * rl.GetFrameTime()
    enemies[i].rect = rl.Rectangle{enemies[i].pos.x, enemies[i].pos.y, 50, 50}

    if rl.CheckCollisionRecs(player.rect, enemy.rect) {
      enemies[i].pos =  {
        f32(rl.GetRandomValue(-1500, 1500)),
        f32(rl.GetRandomValue(-1500, 1500)),
      }
      enemies[i].rect = rl.Rectangle{enemies[i].pos.x, enemies[i].pos.y, 50, 50}
    }
  }

  camera.target = player.pos
}

draw :: proc() {
  rl.BeginDrawing()
  rl.DrawFPS(10, 10)
  defer rl.EndDrawing()

  rl.ClearBackground(rl.BLACK)

  rl.BeginMode2D(camera)
  defer rl.EndMode2D()

  rl.DrawRectangleV(player.pos, SIZE, rl.RED)

  for enemy in enemies {
    rl.DrawRectangleV(enemy.pos, SIZE, rl.GRAY)
  }
}
