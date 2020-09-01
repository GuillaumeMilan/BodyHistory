defmodule HTTP.Router.API do
  require Logger
  use Ewebmachine.Builder.Resources
  resources_plugs nomatch_404: true

  resource "/api/example" do %{} after
    content_types_provided do: ["application/json": :to_json]
    defh to_json do
      Poison.encode!(state[:json_obj])
    end

    resource_exists do
      json = %{
        example: []
      }
      pass(true, json_obj: json)
    end
  end
end
