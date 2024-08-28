package main

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"
import rlgl "vendor:raylib/rlgl"

DARK :: rl.Color{118, 150, 86, 255}
LIGHT :: rl.Color{238, 238, 210, 255}
WHITE :: rl.Color{248, 248, 248, 255}
BLACK :: rl.Color{86, 83, 82, 255}

GREEN :: rl.Color{187, 203, 68, 200}
GRAY :: rl.Color{0, 0, 0, 100}

SIZE :: 100
GAP :: 200

AVAILABLE :: 9

LETTERS := "abcdefgh"
NUMBERS := "87654321"
PIECES := "PRNBQKP"

board: [8][8]i32
active_key: rune
piece_number := i32(-1)
command: [dynamic]rune

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "main")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0))
  rl.SetExitKey(.KEY_NULL)

  init()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

  defer rl.CloseWindow()
}

init :: proc() {
  board = [8][8]i32 {
    {7, 7, 7, 7, 7, 7, 7, 7},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {2, 3, 4, 5, 6, 4, 3, 2},
  }

  // fmt.println(board)
}

clear_board :: proc() {
  for cols, row in board {
    for cell, col in cols {
      if cell == AVAILABLE {
        board[row][col] = 0
      }
    }
  }
}

reset :: proc() {
  active_key = 0
  piece_number = -1
  clear(&command)
  clear_board()
}

update :: proc() {
  // escape
  if rl.IsKeyPressed(.ESCAPE) {
    reset()
  }

  key := rl.GetCharPressed()

  if key != 0 {
    active_key = key
    append(&command, key)

    clear_board()

    if index := strings.index_rune(PIECES, active_key); index >= 0 {
      piece_number = i32(index + 1)
      // fmt.println(piece_number, active_key)

      // set available
      for cols, row in board {
        for cell, col in cols {
          if cell == piece_number {
            maybe_cell1 := &board[row - 1][col]
            maybe_cell2 := &board[row - 2][col]

            if maybe_cell1^ == 0 {
              maybe_cell1^ = AVAILABLE
            }
            if maybe_cell2^ == 0 {
              maybe_cell2^ = AVAILABLE
            }
          }
        }
      }

    }
  }
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)

  rl.DrawText(rl.TextFormat("%c", active_key), (rl.GetScreenWidth() / 2) - 10, 100, 20, WHITE)
  rl.DrawText(rl.TextFormat("%c", command), (rl.GetScreenWidth() / 2) + 10, 100, 20, WHITE)

  for cols, row in board {
    for cell, col in cols {
      // cords
      x := GAP + i32(col) * SIZE
      y := GAP + i32(row) * SIZE

      // values
      number := NUMBERS[row]
      letter := LETTERS[col]
      is_active := piece_number == cell
      // is_available := rune(letter) == active_key || rune(number) == active_key || cell == AVAILABLE
      is_available := cell == AVAILABLE

      // color
      color_even := col % 2 == 0 ? LIGHT : DARK
      color_odd := col % 2 != 0 ? LIGHT : DARK
      color := row % 2 == 0 ? color_even : color_odd

      rl.DrawRectangle(x, y, SIZE, SIZE, color)

      // highlight active cells
      if is_active {
        rl.DrawRectangle(x, y, SIZE, SIZE, GREEN)
      }

      // highlight available cells
      if is_available {
        rl.DrawCircle(x + SIZE / 2, y + SIZE / 2, SIZE / 7, GRAY)
      }

      // pieces
      if cell > 0 && cell <= 7 {
        rl.DrawText(rl.TextFormat("%c", PIECES[cell - 1]), 35 + x, 35 + y, 50, cell == 7 ? BLACK : WHITE)
      }

      // numbers
      if col == 0 {
        rl.DrawText(rl.TextFormat("%c", number), 5 + x, 5 + y, 20, BLACK)
      }

      // letters
      if row == 7 {
        rl.DrawText(rl.TextFormat("%c", letter), 80 + x, 80 + y, 20, BLACK)
      }

    }
  }

  rl.EndDrawing()
}
