json.response do
  json.type params[:type]
  json.query params[:query]
  json.results @refable.nil? ? 0 : 1
end

unless @refable.nil?
  json.result do
    json.partial! 'refable/refable', refable: @refable
  end
end