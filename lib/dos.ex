defmodule Dos do
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")
    #random string generator
    def string_of_length(length) do
     # num = String.to_integer(length)
      Enum.reduce((1..length), [], fn (_i, acc) ->
        [Enum.random(@chars) | acc]
      end) |> Enum.join("")
      
    end
    def hashing(str) do
      :crypto.hash(:sha256,"ayushigarg1992;"<> str)|>Base.encode16
    end
    #to make a pattern leading zeros
    def bit_coin_miner(k) do
      
      #num = String.to_integer(k)
      Enum.reduce((1..k), [], fn (_i, acc) ->
          [0 | acc]
        end) |> Enum.join("")|>checkValueOf(k)
        bit_coin_miner(k)
    end
    def checkValueOf(match,k) do
      hash = hashing(string_of_length(k))
      slice = String.slice(hash,0,k)
      if match==slice
      do
        IO.puts "My coins: "<>"#{hash}"
      
      else
        
      end
    end
      
    
end
