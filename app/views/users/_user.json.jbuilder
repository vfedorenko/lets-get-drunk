json.(user, :id, :name, :image_url)
json.status user.status if @show_status