defmodule Day6 do
  alias Day6.Directions

  def count_distinct_positions(input) do
    parse_input(input)
    |> navigate_guard()
    |> MapSet.size()
  end

  def count_possible_obstructions(input) do
    parse_input(input)
    |> then(&{&1, navigate_guard(&1)})
    |> find_extra_obstructions()
    |> Enum.count()
  end

  defp parse_input(input) do
    map = String.split(input) |> Enum.map(&String.codepoints/1)
    map_size = length(map)
    guard = find_guard(map)
    obstructions = find_obstructions(map)

    {map_size, guard, obstructions}
  end

  defp find_guard(map, guard_indicator \\ "^") do
    y = Enum.find_index(map, &Enum.member?(&1, guard_indicator))
    row = Enum.at(map, y)
    x = Enum.find_index(row, &(&1 == guard_indicator))

    {x, y}
  end

  defp find_obstructions(map) do
    indexed_map(map) |> Enum.flat_map(&row_obstructions/1) |> Map.from_keys(MapSet.new())
  end

  defp row_obstructions({row, y}, obstruction_indicator \\ "#"),
    do:
      row
      |> Enum.filter(&(elem(&1, 0) == obstruction_indicator))
      |> Enum.map(&{elem(&1, 1), y})

  defp indexed_map(map),
    do:
      map
      |> Enum.map(&Enum.with_index/1)
      |> Enum.with_index()

  defp navigate_guard({map_size, guard, obstructions}, direction \\ Directions.initial()),
    do: navigate_guard(guard, direction, map_size, obstructions)

  defp navigate_guard(position, direction, map_size, obstructions, visited \\ %MapSet{}) do
    if check_bounds(position, map_size) do
      MapSet.put(visited, position)
      visited = MapSet.put(visited, position)
      {direction, obstructions} = next_direction(direction, position, obstructions)
      position = navigate(position, direction)
      navigate_guard(position, direction, map_size, obstructions, visited)
    else
      visited
    end
  end

  defp check_bounds({x, y}, map_size),
    do: x >= 0 && x < map_size && y >= 0 && y < map_size

  defp next_direction(direction, position, obstructions) do
    next_position = navigate(position, direction)

    if Map.has_key?(obstructions, next_position) do
      handle_obstruction(obstructions, next_position, direction)
    else
      {direction, obstructions}
    end
  end

  defp handle_obstruction(obstructions, next_position, direction) do
    visited_directions = loop_detection(obstructions, next_position, direction)
    obstructions = Map.replace(obstructions, next_position, visited_directions)

    {Directions.next(direction), obstructions}
  end

  defp loop_detection(obstructions, next_position, direction) do
    visited_directions = Map.get(obstructions, next_position)

    if(MapSet.member?(visited_directions, direction)) do
      raise RuntimeError, "Loop detected!"
    else
      MapSet.put(visited_directions, direction)
    end
  end

  defp navigate({position_x, position_y}, {direction_x, direction_y}),
    do: {position_x + direction_x, position_y + direction_y}

  defp find_extra_obstructions({input, visited}), do: find_extra_obstructions(input, visited)

  defp find_extra_obstructions({map_size, guard, obstructions}, visited),
    do:
      visited
      |> MapSet.delete(guard)
      |> Enum.filter(&find_extra_obstruction(&1, {map_size, guard, obstructions}))

  defp find_extra_obstruction(extra_obstruction, {map_size, guard, obstructions}) do
    extra_obstructions = Map.put(obstructions, extra_obstruction, MapSet.new())

    try do
      _ = navigate_guard({map_size, guard, extra_obstructions})
      false
    rescue
      _ in RuntimeError -> true
    end
  end

  defmodule Directions do
    @north {0, -1}
    @east {1, 0}
    @south {0, 1}
    @west {-1, 0}

    def initial(), do: @north

    def next(direction) do
      case direction do
        @north -> @east
        @east -> @south
        @south -> @west
        @west -> @north
      end
    end
  end
end
