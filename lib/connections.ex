defmodule Ipcons do
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
end