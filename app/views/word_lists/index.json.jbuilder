json.array!(@word_lists) do |word_list|
  json.extract! word_list, :id, :name
  json.url word_list_url(word_list, format: :json)
end
