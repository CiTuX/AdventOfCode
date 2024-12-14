ExUnit.start()

defmodule TestHelper do
  def read_input(env) do
    folder = Path.dirname(env.file)
    input = Path.join(folder, "input.txt")
    File.read!(input)
  end
end
