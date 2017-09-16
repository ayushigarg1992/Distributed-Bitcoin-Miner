defmodule StringGenerator do
    @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")
  
      def string_of_length(length) do
        Enum.reduce((1..length), [], fn (_i, acc) ->
          [Enum.random(@chars) | acc]
        end) |> Enum.join("")
        
      end
    
      def hash_str(str) do
        hash = fn(str)-> :crypto.hash(:sha256,str)|>Base.encode16
      end
  end
end