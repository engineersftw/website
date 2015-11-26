json.count @total_records
json.page @current_page if @current_page
json.data @episodes, partial: 'video', as: :video
