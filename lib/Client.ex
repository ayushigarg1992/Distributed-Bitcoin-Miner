defmodule Client do
  use GenServer
  def start_link do
      {:ok, pid} = Node.start(:"worker1@192.168.0.13")
      cookie = Application.get_env(self(), :cookie)
      Node.set_cookie(cookie)
      Node.connect(:"serverBoss@192.168.0.13")
      GenServer.start_link(__MODULE__,:ok,name: Worker1)
      :global.sync()
      :global.whereis_name(:server) |> send (:"worker1@192.168.0.13")
      
  end
  
 

  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.split("")
  #random string generator
  def string_of_length(length) do
    randomString = Enum.reduce((1..5), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join("")
    
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
    hashed = hashing(string_of_length(k))
    slice = String.slice(hashed,0,k)
    node_name = "serverBoss@192.168.0.13"
    if match==slice
    do
      :global.sync()
      GenServer.cast({Server, :"#{node_name}"},{:receivehash,hashed})
    else
      
    end
  end  


##server side codes
def init(data) do
  {:ok,data}
end

def handle_cast({:param, k}, state) do
  
  IO.puts "Worker 1 #{k}"
  bit_coin_miner(k)
  
  {:noreply, state}
end
def handle_call(:see,_from,list) do
  {:reply,list,list}
end
end