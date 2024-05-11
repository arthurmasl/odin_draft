package main

import "core:fmt"
import rl "vendor:raylib"

entities: [COUNT]Entity

oo_init_entities :: proc() {
  for &entity in entities {
    entity.pos =  {
      f32(rl.GetRandomValue(-RANGE, RANGE)),
      f32(rl.GetRandomValue(-RANGE, RANGE)),
    }
    entity.color =  {
      u8(rl.GetRandomValue(0, 255)),
      u8(rl.GetRandomValue(0, 255)),
      u8(rl.GetRandomValue(0, 255)),
      255,
    }
  }
}

oo_update :: proc() {
  for &entity in entities {
    acc := rl.Vector2Normalize({0, 0} - entity.pos)

    entity.vel *= (1 - 0.9)
    entity.vel += acc * SPEED

    entity.pos += entity.vel * rl.GetFrameTime()

  }
}

oo_draw :: proc() {
  rl.BeginTextureMode(offscreen.target)
  rl.ClearBackground(rl.BLACK)
  rl.BeginMode2D(camera)
  for &entity in entities {
    rl.DrawTextureV(texture, entity.pos, entity.color)
  }
  rl.EndMode2D()
  rl.EndTextureMode()

  rl.BeginDrawing()
  rl.DrawTexturePro(
    offscreen.target.texture,
    offscreen.source,
    offscreen.dest,
    offscreen.origin,
    0,
    rl.WHITE,
  )
  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}

oo_draw_slow :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)
  rl.BeginMode2D(camera)

  for &entity in entities {
    rl.DrawTextureV(texture, entity.pos, rl.WHITE)
  }

  rl.EndMode2D()
  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}
