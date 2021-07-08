class Api::V1::EntriesController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    entry = WtfEntry.find_by(word: params[:word])
    if entry
      render json: entry, status: :ok
    else
      render json: {error: 'Not found'}
    end
  end

  # Create definition of word
  # POST {"wtf_entry": {"word": "some word", "author": "some author", "description": "some definition"}}
  # replace values with actual values to create an entry
  def create
    entry = WtfEntry.new(word: dictionary_params[:word],
                         author: dictionary_params[:author],
                         description: dictionary_params[:description])
    if entry.save
      render json: entry, status: :ok
    else
      render json: {error: 'Error creating entry'}
    end
  end

  def update
    entry = WtfEntry.find_by(id: params[:id])
    if entry.update(dictionary_params)
      render json: entry, status: :ok
    else
      render json: {error: 'Error updating entry'}
    end
  end

  # Destroys entry given an id.
  # DELETE http://localhost:3000/api/v1/entries/id
  # replace id with the entry id to delete
  def destroy
    entry = WtfEntry.find_by(id: params[:id])
    entry&.destroy
    if entry
      render json: entry, status: :ok
    else
      render json: {error: 'Not found'}
    end
  end

  private
    def dictionary_params
      params.require(:wtf_entry).permit([:word, :author, :description])
    end
end
