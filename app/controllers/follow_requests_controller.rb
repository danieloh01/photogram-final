class FollowRequestsController < ApplicationController

  
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :id => the_id })

    @the_follow_request = matching_follow_requests.at(0)

    render({ :template => "follow_requests/show" })
  end

  def create
    # the_follow_request = FollowRequest.new
    # the_follow_request.recipient_id = params.fetch("query_recipient_id")
    # the_follow_request.sender_id = params.fetch("query_sender_id")
    # the_follow_request.status = params.fetch("query_status")

    # if the_follow_request.valid?
    #   the_follow_request.save
    #   redirect_to("/follow_requests", { :notice => "Follow request created successfully." })
    # else
    #   redirect_to("/follow_requests", { :alert => the_follow_request.errors.full_messages.to_sentence })
    # end
    the_follow_request = FollowRequest.new
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")

    # Automatically set the status based on the recipient's privacy setting
    recipient = User.find(the_follow_request.recipient_id)
    the_follow_request.status = recipient.private? ? "pending" : "accepted"

    if the_follow_request.save
      redirect_to("/follow_requests", { notice: "Follow request created successfully." })
    else
      redirect_to("/follow_requests", { alert: the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests/#{the_follow_request.id}", { :notice => "Follow request updated successfully."} )
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def accept
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.find_by(id: the_id, recipient_id: current_user.id, status: "pending")
  
    if the_follow_request
      the_follow_request.update(status: "accepted")
      redirect_to("/follow_requests", { notice: "Follow request accepted!" })
    else
      redirect_to("/follow_requests", { alert: "Follow request not found or already processed." })
    end
  end
  
  def reject
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.find_by(id: the_id, recipient_id: current_user.id, status: "pending")
  
    if the_follow_request
      the_follow_request.update(status: "rejected")
      redirect_to("/follow_requests", { notice: "Follow request rejected." })
    else
      redirect_to("/follow_requests", { alert: "Follow request not found or already processed." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/follow_requests", { :notice => "Follow request deleted successfully."} )
  end
end
