defmodule Server do
    use GenServer
    def start_link(k) do
        
        ip=find_ip_address(1)
        :global.sync()
        spawner(k)
    end
    def workers(node_name,k) do
        #ip = "192.168.0.13"
        GenServer.cast({Worker1, :"#{node_name}"},{:param,k}) 
        
    end

    
    def find_ip_address(i) do
        list = Enum.at(:inet.getif() |> Tuple.to_list,1)
        ip = ""
        if elem(Enum.at(list,i),0) == {127, 0, 0, 1} do
            find_ip_address(i+1) 
        else
         ip = elem(Enum.at(list,i),0) |> Tuple.to_list |> Enum.join(".")
        end
        connection(ip)
       end
    def connection(ip) do
        {:ok, _} = Node.start(:"serverBoss@#{ip}")
        cookie = Application.get_env(self(), :cookie)
        Node.set_cookie(cookie)
        GenServer.start_link(__MODULE__,:ok,name: Server)
    end
    def init(data) do
        {:ok,data}
    end
    def spawner(k) do
        # spawn children
        server = spawn (fn-> 
            listen(k)
    end)
        :global.register_name(:server,server)
        Dos.bit_coin_miner(k)
        
    end
    def listen(k) do
        receive do 
            msg->workers(msg,k)|>IO.puts
        end
        listen(k)
    end
    def init(data) do
        {:ok,data}
    end
    
    def handle_info(hash,state) do
        IO.inspect "Worker 1: #{hash}"
        {:noreply,state}
    end
    def handle_call(:see,_from,msg) do
        {:reply,msg,msg}
    end
    def handle_cast({:receivehash, hashed}, state) do
        
        IO.puts  "worker1 #{hashed}"
        {:noreply,state}
    end

    
end