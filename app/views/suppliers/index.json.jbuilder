json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id
  json.url supplier_url(supplier, format: :json)
end
