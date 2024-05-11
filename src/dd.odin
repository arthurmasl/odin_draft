package main

import rl "vendor:raylib"

ent: [COUNT * 2]rl.Vector2
// pos: [COUNT]rl.Vector2
// vel: [COUNT]rl.Vector2

dd_init_entities :: proc() {
  for i in 0 ..< COUNT {
    ent[i] =  {
      f32(rl.GetRandomValue(-RANGE, RANGE)),
      f32(rl.GetRandomValue(-RANGE, RANGE)),
    }
  }
}

dd_update :: proc() {
  for i in 0 ..< COUNT {
    acc := rl.Vector2Normalize({0, 0} - ent[i])

    ent[i + COUNT] *= (1 - 0.9)
    ent[i + COUNT] += acc * SPEED

    ent[i] += ent[i + COUNT] * rl.GetFrameTime()
  }
}

dd_draw :: proc() {
  rl.BeginTextureMode(offscreen.target)
  rl.ClearBackground(rl.BLACK)
  rl.BeginMode2D(camera)
  for i in 0 ..< COUNT {
    rl.DrawTextureV(texture, ent[i], rl.WHITE)
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
