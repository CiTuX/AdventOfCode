defmodule Day5 do
  def start(_type, _args) do
    {:ok, self()}
  end

  def validated_middle_page_sum(input) do
    [rules, updates] = String.split(input, "\n\n", trim: false) |> Enum.map(&String.split/1)
    rules = parse_rules(rules)
    updates = parse_updates(updates)
    valid_updates = validate_updates(updates, rules)
    Enum.reduce(valid_updates, 0, &(get_middle_page(&1) + &2))
  end

  defp parse_rules(rules),
    do:
      rules
      |> Enum.map(&String.split(&1, "|"))
      |> Enum.group_by(&Enum.at(&1, 0), &Enum.at(&1, 1))

  defp parse_updates(updates),
    do: Enum.map(updates, &String.split(&1, ","))

  defp validate_updates(updates, rules),
    do: Enum.filter(updates, &validate_update?(Enum.reverse(&1), rules))

  defp validate_update?(update, rules),
    do:
      update
      |> Enum.with_index()
      |> Enum.all?(&validate_update?(update, elem(&1, 0), elem(&1, 1), rules))

  defp validate_update?(update, page, index, rules) do
    rule = Map.get(rules, page)

    if rule == nil do
      true
    else
      remaining_pages = Enum.slice(update, (index + 1)..Enum.count(update))
      remaining_pages -- rule == remaining_pages
    end
  end

  defp get_middle_page(pages),
    do: String.to_integer(Enum.at(pages, round(Enum.count(pages) / 2) - 1))
end
