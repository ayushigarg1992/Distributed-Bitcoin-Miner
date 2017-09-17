defmodule Client do
  use GenServer
<<<<<<< HEAD
  def start_link(server_ip) do
      IO.puts ("#{server_ip}")
      set_server(server_ip)
      ip_add = find_ip_address(1)
=======
  def start_link do
      ip_add = Server.find_ip_address(1)
>>>>>>> b0e750441b53d3886e2dda7a7fb91bd98e9174af
      IO.puts("#{ip_add}")
      {:ok, pid} = Node.start(:"worker1@#{ip_add}")
      cookie = Application.get_env(self(), :cookie)
      Node.set_cookie(cookie)
      Node.connect(:"serverBoss@#{server_ip}")
      GenServer.start_link(__MODULE__,:ok,name: Worker1)
      :global.sync()
      :global.whereis_name(:server) |> send (:"worker1@#{ip_add}")
      
  end
<<<<<<< HEAD
  def set_server(ip) do
    server = ip
  end
  def find_ip_address(i) do
    list = Enum.at(:inet.getif() |> Tuple.to_list,1)
    ip = ""
    if elem(Enum.at(list,i),0) == {127, 0, 0, 1} do
     find_ip_address(i+1) 
    else
     ip = elem(Enum.at(list,i),0) |> Tuple.to_list |> Enum.join(".")
    end
   end
=======

>>>>>>> b0e750441b53d3886e2dda7a7fb91bd98e9174af
  
 

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
  def bit_coin_miner(k, ip) do
    Enum.reduce((1..k), [], fn (_i, acc) ->
        [0 | acc]
      end) |> Enum.join("")|>checkValueOf(k, ip)
      bit_coin_miner(k, ip)
  end
  def checkValueOf(match,k, server_ip) do
    hashed = hashing(string_of_length(k))
    slice = String.slice(hashed,0,k)
    
    node_name = "serverBoss@#{server_ip}"
    IO.puts ("#{node_name}")
    
    
    if match==slice
    do
<<<<<<< HEAD
      #IO.puts "#{hashed}"
=======
>>>>>>> b0e750441b53d3886e2dda7a7fb91bd98e9174af
      :global.sync()
      GenServer.cast({Server, :"#{node_name}"},{:receivehash,hashed})
    else
      
    end
  end  


##server side codes
def init(data) do
  {:ok,data}
end

def handle_cast({:param, k, ip}, state) do
  
  IO.puts "Worker 1 #{k}"
  bit_coin_miner(k, ip)
  
  {:noreply, state}
end
def handle_call(:see,_from,list) do
  {:reply,list,list}
end
end