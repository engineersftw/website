json.videos do
  json.meta do
    json.current_page @current_page
    json.total_records @total_records
    json.per_page @per_page
  end
  json.data do
    json.partial! 'episodes/video', collection: @videos, as: :video
  end
end