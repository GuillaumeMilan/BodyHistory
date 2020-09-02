defmodule ETSDatabase do
  use GenServer

  @type table :: atom | reference

  @type ets_opts :: list(atom | {atom, term})

  @type start_link_opts :: %{
    required(:ets_name) => atom,
    optional(:ets_backupfile) => String.t(),
    optional(:ets_opts) => ets_opts,
  }

  @doc false
  def genserver_name(ets_name), do: Module.concat(__MODULE__, ets_name)

  @spec start_link(start_link_opts) :: :ok
  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: genserver_name(opts.ets_name))

  @doc false
  def init(opts) do
    IO.inspect(opts.ets_name, label: "CREATING ETS")
    {:ok, opts, {:continue, :load_table}}
  end

  @doc false
  def handle_continue(:load_table, %{ets_name: ets_name, ets_backupfile: ets_backupfile} = state) do
    ets = case :ets.file2tab('#{ets_backupfile}') do
      {:ok, ets} -> ets
      _ -> :ets.new(ets_name, state[:ets_opts])
    end

    {:noreply, Map.merge(state, %{ets: ets})}
  end
  def handle_continue(:load_table, %{ets_name: ets_name} = state) do
    {:noreply, Map.merge(state, %{ets: :ets.new(ets_name, state[:ets_opts])})}
  end

  @doc false
  def handle_call({:get, id}, _, %{ets_name: ets_name} = state) do
    {:reply, get(ets_name, id), state}
  end
  def handle_call({:put, id, value}, _, %{ets_name: ets_name} = state) do
    {:reply, put(ets_name, id, value), state}
  end



  @spec get(table, term) :: list({term, term}) | {:error, term}
  def get(table, id) do
    :ets.lookup(table, id)
  end

  @spec put(table, term, term) :: boolean
  def put(table, id, value) do
    :ets.insert(table, {id, value})
  end

  @spec transactional_get(atom, term) :: list({term, term}) | {:error, term}
  def transactional_get(ets_name, id) do
    GenServer.call(genserver_name(ets_name), {:get, id})
  end

  @spec transactional_put(atom, term, term) :: boolean
  def transactional_put(ets_name, id, value) do
    GenServer.call(genserver_name(ets_name), {:put, id, value})
  end
end
