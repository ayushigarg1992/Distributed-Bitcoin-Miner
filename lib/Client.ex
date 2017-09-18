defmodule Client do
  use GenServer
  
  def start_link(server_ip) do
      ip_add = find_ip_address(1)

      {:ok, pid} = Node.start(:"worker2@#{ip_add}")
      cookie = Application.get_env(self(), :cookie)
      Node.set_cookie(cookie)
      :global.sync()
      Node.connect(:"serverBoss@#{server_ip}")
      GenServer.start_link(__MODULE__,:ok,name: Worker1)
      :global.sync()
      :global.whereis_name(:server) |> send (:"worker2@#{ip_add}")
      
  end
  def find_ip_address(i) do
    list = Enum.at(:inet.getif() |> Tuple.to_list,1)
    ip = ""
    if elem(Enum.at(list,i),0) == {127, 0, 0, 1} do
        find_ip_address(i+1) 
    else
     ip = elem(Enum.at(list,i),0) |> Tuple.to_list |> Enum.join(".")
    end
    #connection(ip)
   end
def connection(ip) do
    {:ok, _} = Node.start(:"serverBoss@#{ip}")
    cookie = Application.get_env(self(), :cookie)
    Node.set_cookie(cookie)
    GenServer.start_link(__MODULE__,:ok,name: Server)
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
    node_name = Enum.at(Node.list,0)
    
    if match==slice
    do
      IO.puts "#{hashed}"
      GenServer.cast({Server, :"#{node_name}"},{:receivehash,hashed})
    else
      
    end
  end 


##server side codes
def init(data) do
  {:ok,data}
end

def handle_cast({:param, k}, state) do
  
  IO.puts "Worker 1 says #{k}"
  bit_coin_miner(k)
  
  {:noreply, state}
end
def handle_call(:see,_from,list) do
  {:reply,list,list}
end
end