defmodule BodyHistory.Points do

  def database do
    %{ets_name: :points, ets_backupfile: 'data/points.ets', ets_opts: [:public, :named_table, :set, write_concurrency: true]}
  end

  def store_point(user, position, date, comment) do
    #ETSDatabase.put(database().ets_name, {})
  end
end
