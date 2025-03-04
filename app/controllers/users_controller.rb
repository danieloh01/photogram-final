class UsersController < ApplicationController
  def index
    matching_user = User.all

    @list_of_users = matching_user.order({ :created_at => :desc })

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })


    render({ :template => "users/index" })
  end

  def warning
    redirect_back(fallback_location: root_path, notice: "You're not authorized for that.")
  end

  def feed
    matching_user = User.all

    @list_of_users = matching_user.order({ :created_at => :desc })

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })


    render({ :template => "users/feed" })
  end

  def liked_photos
    matching_user = User.all

    @list_of_users = matching_user.order({ :created_at => :desc })

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })


    render({ :template => "users/liked_photos" })
  end

  def discover
    matching_user = User.all

    @list_of_users = matching_user.order({ :created_at => :desc })

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })


    render({ :template => "users/discover" })
  end


  def show

    @user = User.find_by(username: params[:username])
  
    # if @user.nil?
    #   redirect_to users_path, alert: "User not found"
    # end
    the_id = params.fetch("username")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "users/show" })
  end

  def show

    @user = User.find_by(username: params[:username])
  
    # if @user.nil?
    #   redirect_to users_path, alert: "User not found"
    # end
    the_id = params.fetch("username")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })


    # @pending_requests = @the_user.received_follow_requests.where(status: :pending)

    render({ :template => "users/show" })
  end

  def create
    the_user = User.new
    the_user.caption = params.fetch("query_caption")
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.image = params.fetch("query_image")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.owner_id = params.fetch("query_owner_id")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.caption = params.fetch("query_caption")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.image = params.fetch("query_image")
    the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.owner_id = params.fetch("query_owner_id")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
