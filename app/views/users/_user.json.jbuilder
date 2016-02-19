json.(user, :id, :name, :image)
json.status user.status if @show_status