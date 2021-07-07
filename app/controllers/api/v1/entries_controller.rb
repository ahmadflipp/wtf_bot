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

  # Create definition
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

  def delete
    entry = WtfEntry._delete_record(word: dictionary_params[:word])
    if entry > 0
      render status: :ok
    else
      render error: 'Not found'
    end
  end

  private
    def dictionary_params
      params.require(:wtf_entry).permit([:word, :author, :description])
    end
end
