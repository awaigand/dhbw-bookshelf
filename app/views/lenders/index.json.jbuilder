json.array!(@lenders) do |lender|
  json.extract! lender, :id, :name, :street, :city
  json.url lender_url(lender, format: :json)
end
