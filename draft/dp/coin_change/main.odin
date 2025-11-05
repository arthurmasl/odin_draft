package main

import "core:fmt"
import "core:slice"

main :: proc() {
  amount := 7
  coins := []int{1, 3, 7, 4, 5}

  dp := make([]int, amount + 1)
  slice.fill(dp, amount + 1)
  dp[0] = 0
  fmt.println(dp)

  for a in 1 ..< amount + 1 {
    for c in coins {
      if a - c >= 0 do dp[a] = min(dp[a], 1 + dp[a - c])
    }
  }

  fmt.println(dp)
  fmt.println(dp[amount])
}
