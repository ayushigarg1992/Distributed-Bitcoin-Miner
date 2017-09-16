defmodule Dos do
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
    def pattern(k) do
      matcher = Enum.reduce((1..k), [], fn (_i, acc) ->
          [0 | acc]
        end) |> Enum.join("")|>checkValueOf(k)
        #IO.puts matcher
      pattern(k)
    end
    def checkValueOf(match,k) do
      slice = String.slice(hashing(string_of_length(5)),0,k)
      if match==slice
      do
        IO.puts "true-" <>"#{match}"<>"- "<>"#{slice}"<> "#{String.slice(hashing(string_of_length(5)),0,k)}"
      
      else
        
      end
    end
      def hash_str(strs) do
      Enum.each strs, fn str ->" #{:crypto.hash(:sha256,"ayushigarg1992"<> str)|>Base.encode16}" |> IO.puts
      
      end
    end
end
