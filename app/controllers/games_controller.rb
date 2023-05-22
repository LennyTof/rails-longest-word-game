require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @response = params[:answer]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@response}"
    url_bis = URI.open(url).read
    user = JSON.parse(url_bis)
    if @response.split('').all? { |letter| @letters.include?(letter.upcase) }
      @api = user['found']
      if @api == true
        @display = "You won with your word #{@response.capitalize}, congratulation !!"
      else
        @display = "Sorry #{@response.capitalize} isn't an english word, you lost :("
      end
    else
      @display = "Troller, #{@response.capitalize} does not use the correct letter !!"
    end
  end
end
