defmodule Miner do
  use GenServer
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")
    #random string generator
    def string_of_length(length) do
      randomString = Enum.reduce((1..5), [], fn (_i, acc) ->
        [Enum.random(@chars) | acc]
      end) |> Enum.join("")
      
    end
    #to append gatorid to hash a string
    def hashingDiff(k) do
      stringToHash  = string_of_length(5)
      hash = :crypto.hash(:sha256,"ayushigarg1992;"<> stringToHash)|>Base.encode16|> IO.puts
      #match(k,hash)

    end
    def hashing(str) do
      :crypto.hash(:sha256,"ayushigarg1992;"<> str)|>Base.encode16
    end
    #to make a pattern leading zeros
    def bit_coin_miner(k) do
      Enum.reduce((1..k), [], fn (_i, acc) ->
          [0 | acc]
        end) |> Enum.join("")|>checkValueOf(k)
        bit_coin_miner(k)
    end
    def checkValueOf(match,k) do
      hash = hashing(string_of_length(k))
      slice = String.slice(hash,0,k)
      node_name = "ayushi@192.168.0.13"
      if match==slice
      do
        IO.puts "#{hash}"<>"#{node_name}"
        GenServer.cast({Ayushi, :"#{node_name}"},{:item,hash}) 
        #GenServer.cast({, :"#{node_name}"},{:item, hash})  |> IO.puts       
      else
        
      end
    end  
end