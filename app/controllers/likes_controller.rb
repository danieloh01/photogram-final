# class LikesController < ApplicationController
#   def index
#     matching_likes = Like.all

#     @list_of_likes = matching_likes.order({ :created_at => :desc })

#     render({ :template => "likes/index" })
#   end

#   def show
#     the_id = params.fetch("path_id")

#     matching_likes = Like.where({ :id => the_id })

#     @the_like = matching_likes.at(0)

#     render({ :template => "likes/show" })
#   end

#   def create
#     the_like = Like.new
#     the_like.fan_id = params.fetch("query_fan_id")
#     the_like.photo_id = params.fetch("query_photo_id")

#     if the_like.valid?
#       the_like.save
#       redirect_to("/likes", { :notice => "Like created successfully." })
#     else
#       redirect_to("/likes", { :alert => the_like.errors.full_messages.to_sentence })
#     end
#   end

#   def update
#     the_id = params.fetch("path_id")
#     the_like = Like.where({ :id => the_id }).at(0)

#     the_like.fan_id = params.fetch("query_fan_id")
#     the_like.photo_id = params.fetch("query_photo_id")

#     if the_like.valid?
#       the_like.save
#       redirect_to("/likes/#{the_like.id}", { :notice => "Like updated successfully."} )
#     else
#       redirect_to("/likes/#{the_like.id}", { :alert => the_like.errors.full_messages.to_sentence })
#     end
#   end

#   def destroy
#     the_id = params.fetch("path_id")
#     the_like = Like.where({ :id => the_id }).at(0)

#     the_like.destroy

#     redirect_to("/likes", { :notice => "Like deleted successfully."} )
#   end
# end


class LikesController < ApplicationController
  def index
    matching_likes = Like.all

    @list_of_likes = matching_likes.order({ :created_at => :desc })

    render({ :template => "likes/index" })
  end

  def destroy
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.destroy

    # redirect_to(fallback_location: root_path, { :notice => "Like deleted successfully."})
    redirect_back(fallback_location: root_path, notice: "Like deleted successfully.")
  end

  def show
    the_id = params.fetch("path_id")

    matching_likes = Like.where({ :id => the_id })

    @the_like = matching_likes.at(0)

    render({ :template => "likes/show" })
  end

  # def create
  #   the_like = Like.new
  #   the_like.fan_id = params.fetch("query_fan_id")
  #   the_like.photo_id = params.fetch("query_photo_id")

  #   if the_like.valid?
  #     the_like.save
  #     flash[:notice] = "You liked the photo successfully!"
  #     redirect_to root_path # Redirecting to home page, or the path where you want to display the notice
  #   else
  #     redirect_to("/likes", { :alert => the_like.errors.full_messages.to_sentence })
  #   end
  # end

  # def create
  #   # Use the current user to set fan_id and fetch photo_id from the params
  #   the_like = Like.new(like_params)
  
  #   # Check if the Like is valid and can be saved
  #   if the_like.save
  #     redirect_to("/photos/#{the_like.photo_id}", notice: "Like created successfully!")
  #   else
  #     redirect_to("/photos/#{the_like.photo_id}", alert: "Failed to create like.")
  #   end
  # end

  # def create
  #   # Find if the user has already liked the photo
  #   existing_like = Like.find_by(fan_id: params.fetch("query_fan_id"), photo_id: params.fetch("query_photo_id"))
    
  #   if existing_like
  #     # If the like exists, delete it (dislike action)
  #     existing_like.destroy
  #     # Redirect with a message indicating the photo was disliked
  #     redirect_to("/photos/#{params.fetch('query_photo_id')}", notice: "You have disliked this photo.")
  #   else
  #     # Otherwise, create a new like
  #     the_like = Like.new(like_params)
  
  #     # Save the new like and redirect
  #     if the_like.save
  #       redirect_to("/photos/#{the_like.photo_id}", notice: "Like created successfully!")
  #     else
  #       redirect_to("/photos/#{the_like.photo_id}", alert: "Failed to create like.")
  #     end
  #   end
  # end

  def create
    # Fetch fan_id and photo_id from the params
    fan_id = params.fetch("fan_id")
    photo_id = params.fetch("photo_id")
  
    # Check if the user has already liked this photo
    existing_like = Like.find_by(fan_id: fan_id, photo_id: photo_id)
  
    if existing_like
      # If the like exists, remove it (Dislike action)
      existing_like.destroy
      redirect_to("/photos/#{photo_id}", notice: "You have disliked this photo.")
    else
      # If the like doesn't exist, create a new like (Like action)
      the_like = Like.new(fan_id: fan_id, photo_id: photo_id)
  
      if the_like.save
        redirect_to("/photos/#{photo_id}", notice: "Like created successfully!")
      else
        redirect_to("/photos/#{photo_id}", alert: "Failed to create like.")
      end
    end
  end
  
  
  private
  
  # Define strong parameters
  # def like_params
  #   # Ensure only the necessary fields are being passed, and merge the fan_id from the current user
  #   params.require(:like).permit(:photo_id).merge(fan_id: current_user.id)
  # end

  def like_params
    params.require(:like).permit(:fan_id, :photo_id)
  end



  def update
    the_id = params.fetch("path_id")
    the_like = Like.where({ :id => the_id }).at(0)

    the_like.fan_id = params.fetch("query_fan_id")
    the_like.photo_id = params.fetch("query_photo_id")

    if the_like.valid?
      the_like.save
      redirect_to("/likes/#{the_like.id}", { :notice => "Like updated successfully."} )
    else
      redirect_to("/likes/#{the_like.id}", { :alert => the_like.errors.full_messages.to_sentence })
    end
  end

  
end
