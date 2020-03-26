module V1
  class CommentsController < ApplicationController
    skip_before_action :authorize_request, only: %i[index]
    before_action :set_comment, only: %i[update destroy]

    # GET /movies/:movie_id/comments
    def index
      json_response(MovieComment.where(movie_id: params[:movie_id]))
    end

    # POST /movies/:movie_id/comments
    def create
      comment = comment_params || return
      @comment = MovieComment.create!(comment)
      json_response(@comment, :created)
    end

    # PUT /movies/:movie_id/comments/:id
    def update
      # TODO
    end

    # DELETE /movies/:movie_id/comments/:id
    def destroy
      if (@comment[:user] == @current_user[:id])
        @comment.destroy!
        head :no_content
      else
        json_response({ message: "You cannot delete other user's comments" }, :forbidden)
      end
    end

    private

    def comment_params
      params.require(:text)
      params.permit(:id, :text, :movie_id, :parent_id)
    end

    def set_comment
      @comment = MovieComment.find(params[:id])
    end
  end
end
