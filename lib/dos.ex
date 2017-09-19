defmodule Dos do
  
  def repeat do
      receive do
          {input, k} -> check_string{input, k}
      end
  end

  def check_string{input, k} do
      hash = Base.encode16(:crypto.hash(:sha256, input))
      # num = String.to_integer(k)
      leading_zeros = String.slice(hash, 0..k-1)
      ch = String.to_charlist(leading_zeros)
      temp = Enum.all?(ch, fn(x) -> x == 48 end)
      if temp == true do
        IO.puts "#{input}" <> "     " <> "#{hash}"
      end
  end


  def looping(k) do
      pids = Enum.map(1..100, fn (_) -> spawn(&Dos.repeat/0) end)
      Enum.each pids, fn pid ->
          rand = :crypto.strong_rand_bytes(5) |> Base.encode64 |> binary_part(0,5)
          input = Enum.join(["ayushigarg1992", rand], ";")
          send(pid, {input, k})
          
      end
      looping(k)
  end
      
    
end