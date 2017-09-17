defmodule Server do
    use GenServer
    def start_link(k) do
        {:ok, _} = Node.start(:"ayushi@192.168.0.13")
        cookie = Application.get_env(self(), :cookie)
        Node.set_cookie(cookie)
        GenServer.start_link(__MODULE__,name: Ayushi)
        spawner(k)
    end
    def workers(msg,k) do
        node_name= "#{msg}"
        GenServer.cast({Pooja, :"#{node_name}"},{:name,k}) 
        
    end
    def spawner(k) do
        # spawn children
        server = spawn (fn-> 
            listen(k)
    end)
        :global.register_name(:server,server)|>IO.puts
        IO.puts "one"
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
    
    def handle_cast({:item, hash,slice}, state) do
        
        IO.puts  "worker1"<>"#{hash}"<>" #{slice}"
        {:noreply,state}
    end

    
end