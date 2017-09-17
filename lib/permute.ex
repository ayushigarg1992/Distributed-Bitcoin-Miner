defmodule Permutations do
  def shuffle(list), do: shuffle(list, length(list))

  def shuffle([], _), do: [[]]
  def shuffle(_,  0), do: [[]]
  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i-1), do: [x|y]
  end
  def joins do
      Enum.each(shuffle([1,2,3]),fn(x)->Enum.join(x,"")|>IO.puts end)#|>Enum.join("")
  end

end