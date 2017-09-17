defmodule Server do
    use GenServer
    def start_link(k) do
        {:ok, _} = Node.start(:"ayushi@192.168.0.13")
        cookie = Application.get_env(self(), :cookie)
        Node.set_cookie(cookie)
        #Node.connect(:"pooja@192.168.0.20")
        spawner(k)
        GenServer.start_link(__MODULE__,name: Ayushi)
    end
    def workers(k) do
        node_name= "#{k}"
        GenServer.cast({Pooja, :"#{node_name}"},{:name,3}) 
    end
    def spawner(k) do
        # spawn children
        server = spawn (fn-> 
            receive do 
                #msg->IO.puts
               msg->workers(msg)|>IO.puts
        end
    end)
        :global.register_name(:server,server)
        Dos.bit_coin_miner(5)
        #spawner(k)
    end
    def init(data) do
        {:ok,data}
    end
    
    def handle_cast({:item, k}, state) do
        IO.puts "From Pooja "<>"#{k}"
        {:item,state}
    end

    
end