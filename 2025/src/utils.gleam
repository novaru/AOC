import gleam/result
import gleam/string
import simplifile

/// Read input file for a given day
pub fn read_input(day: Int) -> Result(String, String) {
  let path = "src/input_day" <> string.inspect(day) <> ".txt"
  simplifile.read(path)
  |> result.map_error(fn(err) {
    "Failed to read file " <> path <> ": " <> string.inspect(err)
  })
}

/// Read input file and split into lines (filters out empty lines)
pub fn read_lines(day: Int) -> List(String) {
  read_input(day)
  |> result.unwrap("")
  |> string.split("\n")
}
