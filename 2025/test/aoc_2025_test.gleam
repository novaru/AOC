import day1
import gleam/io
import gleeunit
import utils

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn day1_test() {
  io.println("Testing Day 1")
  let lines = utils.read_lines(1)
  assert day1.solve_part1(lines) == 1141
  assert day1.solve_part2(lines) == 6634
}
