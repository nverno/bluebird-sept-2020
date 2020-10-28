class ChirpsController < ApplicationController
    def index
        chirps = Chirp.all
        render json: chirps
    end

    def show
        # this should get the info of one specific chirp and render it
        chirp = Chirp.find_by(id: params[:id])
        # chirp = Chirp.find(params[:id])
        render json: chirp
    end

    def create
        # create a new chirp, 
        # save it to the db,
        # redirect to show if success, 
        # render errors if fail
    
        # {"body"=>"poikjnertgboijkitrmbtr", "author_id"=>"18"}
        # body: 'awdawda', author_id: 18
        # params[:somethiong] = 'banana'
        chirp = Chirp.new(chirp_params)
        
        if chirp.save
            redirect_to chirp_url(chirp)
        else
            render json: chirp.errors.full_messages, status: 422
        end
    end

    def update
        # find the chirp we are updating
        # attempt to update it
        # if success, redirect to the show
        # send errors
        chirp = Chirp.find_by(id: params[:id])

        if chirp.update(chirp_params)
            redirect_to chirp_url(chirp)
        else
            render json: chirp.errors.full_messages, status: 422
        end
    end

    def destroy
        # find the chirp we are destroying
        # destroy it
        # redirect to show or index
        chirp = Chirp.find_by(id: params[:id])

        chirp.destroy
        redirect_to chirps_url # sends to the index action
    end

    private

    def chirp_params
        params.require(:chirp).permit(:body, :author_id)
    end
end