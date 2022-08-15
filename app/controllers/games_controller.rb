require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet_array = ('a'..'z').to_a
    @letters_array = []
    10.times { @letters_array << alphabet_array[rand(0..25)] }
  end

  def score
    my_data_url_into_hash = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
    letters_array = params[:letters].downcase.split(',')
    word_array = params[:word].downcase.split('')
    letters_matched = []
    word_array.each do |letter|
      if letters_array.include?(letter)
        letters_matched << letter
        letters_array.delete_at(letters_array.index(letter))
      end
    end
    @msg =
      if letters_matched.size == word_array.size
        if my_data_url_into_hash['found'] == false
          "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
        else
          "Congratulations! #{params[:word].upcase} is a valid English word!"
        end
      else
        "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters].upcase}"
      end
  end
end
