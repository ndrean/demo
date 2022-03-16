defmodule DemoWeb.Airports.List do
  def search_by_code(""), do: []

  def search_by_code(airport_code) do
    list_airports()
    |> Enum.filter(
      &String.starts_with?(
        &1.code,
        String.upcase(airport_code)
      )
    )
  end

  def list_airports do
    [
      %{name: "Berlin Brandenburg", code: "BER", id: 1},
      %{name: "Berlin Schönefeld", code: "SXF", id: 2},
      %{name: "Berlin Tegel", code: "TXL", id: 3},
      %{name: "Bremen", code: "BRE", id: 4},
      %{name: "Köln/Bonn", code: "CGN", id: 5},
      %{name: "Dortmund", code: "DTM", id: 6},
      %{name: "Dresden", code: "DRS", id: 7},
      %{name: "Düsseldorf", code: "DUS", id: 8},
      %{name: "Frankfurt", code: "FRA", id: 9},
      %{name: "Frankfurt-Hahn", code: "HHN", id: 10},
      %{name: "Hamburg", code: "HAM", id: 11},
      %{name: "Hannover", code: "HAJ", id: 12},
      %{name: "Leipzig Halle", code: "LEJ", id: 13},
      %{name: "München", code: "MUC", id: 14},
      %{name: "Münster Osnabrück", code: "FMO", id: 15},
      %{name: "Nürnberg", code: "NUE", id: 16},
      %{name: "Paderborn Lippstadt", code: "PAD", id: 17},
      %{name: "Stuttgart", code: "STR", id: 18}
    ]
  end
end
