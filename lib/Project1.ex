defmodule Project1 do
    use GenServer
    def main(args) do
        args|>parse
        receive do
            {:end} -> IO.puts "End"
          end     
               
    end
    def parse(args) do
            if Regex.match?(~r/\./,to_string(args)) do
            Client.start_link(Enum.at(args,0))
            IO.puts args
            else
            {num,_} = Integer.parse(Enum.at(args,0))
            start_link(num)
            end
        
    end
    def start_link(k) do
        
        ip=find_ip_address(0)
        :global.sync()
        spawner(k)
    end
    def workers(node_name,k) do
        IO.puts "node name is #{node_name} and parameter is #{k}"
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
        server = spawn (fn-> 
            listen(k)
        end)
        :global.sync()
        :global.register_name(:server,server)
        Dos.looping(k)
        
    end
    def listen(k) do
        receive do 
            msg->workers(msg,k) 
        end
        listen(k)
    end
    def init(set) do
        {:ok,set}
    end
    
    # def view(node_name) do
    #     GenServer.call({Server, :"#{node_name}"},:view)
    # end
    # def handle_call(:view,_from,set) do
    #     {:reply,set,set}
    # end
    def handle_cast({:receivehash, hashed, random}, state) do
        
        IO.puts  "ayushigarg1992;#{random}     #{hashed}"
        {:noreply,state}
    end

    
end