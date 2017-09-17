defmodule Server do
    use GenServer
    def start_link(k) do
        #ip_add = find_ip_address(1)
        {:ok, _} = Node.start(:"serverBoss@192.168.0.20")
        cookie = Application.get_env(self(), :cookie)
        Node.set_cookie(cookie)
        GenServer.start_link(__MODULE__,:ok,name: Server)
        :global.sync()
        spawner(k)
    end
    def workers(node_name,k) do
        GenServer.cast({Worker1, :"#{node_name}"},{:param,k}) 
        
    end

    

    def spawner(k) do
        # spawn children
        server = spawn (fn-> 
            listen(k)
    end)
        :global.register_name(:server,server)
        #Dos.bit_coin_miner(k)
        
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