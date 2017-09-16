defmodule Server do
    use GenServer
    def start_link do
        {:ok, _} = Node.start(:"ayushi@192.168.0.13")
        cookie = Application.get_env(self(), :cookie)
        Node.set_cookie(cookie)
        Node.connect(:"pooja@192.168.0.20")
        server = spawn (fn-> 
            receive do 
                msg->IO.puts "I got something #{inspect msg}"
            end
        end)
        
        :global.register_name(:server,server)
        GenServer.start_link(__MODULE__,:ok,name: Ayushi)
    end
    def workers(pid,k) do
        GenServer.cast(pid,k)
    end

    def init(data) do
        {:ok,data}
    end
    def see(pid) do
        GenServer.call(pid,:see)
    end
    def handle_cast(item,list) do
        list_ = [item|list]
        {:noreply,list_}
    end
    def handle_call(:see,_from,list) do
        {:reply,list,list}
    end
end