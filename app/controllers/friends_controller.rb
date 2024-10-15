class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]

  # Rescue from specific exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  # GET /friends or /friends.json
  def index
    @friends = Friend.all
  end

  # GET /friends/1 or /friends/1.json
  def show; end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit; end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)
    @friend.save!  # This will raise an exception if the record is invalid

    respond_to do |format|
      format.html { redirect_to @friend, notice: "Friend was successfully created." }
      format.json { render :show, status: :created, location: @friend }
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    @friend.update!(friend_params)  # Raises an exception if the record is invalid

    respond_to do |format|
      format.html { redirect_to @friend, notice: "Friend was successfully updated." }
      format.json { render :show, status: :ok, location: @friend }
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy!
    respond_to do |format|
      format.html { redirect_to friends_path, status: :see_other, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :twitter)
    end

    # Handle record not found errors (e.g., when finding a friend fails)
    def record_not_found
      respond_to do |format|
        format.html { redirect_to friends_path, alert: "Friend not found." }
        format.json { render json: { error: "Friend not found" }, status: :not_found }
      end
    end

    # Handle invalid record errors (e.g., validation errors)
    def handle_invalid_record(exception)
      respond_to do |format|
        format.html { render :new, alert: exception.message }
        format.json { render json: { error: exception.message }, status: :unprocessable_entity }
      end
    end
end










