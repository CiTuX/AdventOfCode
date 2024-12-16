defmodule Day5 do
  def validated_middle_page_sum(input) do
    [rules, updates] = parse_input(input)
    valid_updates = validate_updates(updates, rules)
    middle_page_sum(valid_updates)
  end

  def fixed_middle_page_sum(input) do
    [rules, updates] = parse_input(input)
    valid_updates = validate_updates(updates, rules)
    invalid_updates = updates -- valid_updates
    fixed_updates = fix_updates(invalid_updates, rules)
    middle_page_sum(fixed_updates)
  end

  defp parse_input(input) do
    [rules, updates] = String.split(input, "\n\n", trim: false) |> Enum.map(&String.split/1)
    [parse_rules(rules), parse_updates(updates)]
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

  defp fix_updates(updates, rules), do: Enum.map(updates, &fix_update(&1, rules))

  defp fix_update(update, rules) do
    Enum.sort_by(update, &Function.identity/1, &compare_pages(&1, &2, rules))
  end

  defp compare_pages(page_left, page_right, rules),
    do: Map.get(rules, page_left, []) |> Enum.member?(page_right)

  defp validate_update?(update, page, index, rules) do
    rule = Map.get(rules, page)

    if rule == nil do
      true
    else
      remaining_pages = Enum.slice(update, (index + 1)..Enum.count(update))
      remaining_pages -- rule == remaining_pages
    end
  end

  defp middle_page_sum(updates),
    do: Enum.reduce(updates, 0, &(get_middle_page(&1) + &2))

  defp get_middle_page(pages),
    do: Enum.at(pages, round(Enum.count(pages) / 2) - 1) |> String.to_integer()
end
