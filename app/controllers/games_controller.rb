require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def game 
    @start_time = Time.now
     generate_grid

  end

  def generate_grid
    @letters = []
    10.times do
      @letters << (65 + rand(25)).chr
    end
     @letters
  end

  def answer
    end_time = Time.now
    start_time = Time.parse(params[:start_time])
    @result = { time: end_time - start_time}
    score_and_message = score_and_message(params[:word], params[:grid], @result[:time])
    @result[:score] = score_and_message.first
  @result[:message] = score_and_message.last
  @result[:message]
  end


def score_and_message(word, grid, time)
  if include_letter?(word.upcase, grid)
    if finding_word?(word)
      score = compute_score(word, time)
      
      [score, "well done"]
    else
      [0, "not an english word"]
    end
  else
    [0, "not in the grid"]
  end
end

  def include_letter?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def finding_word?(word)
    res = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(res.read)
    json['found']
  end
  def compute_score(word, time)
    time > 60.0 ? 0 : word.size * (1.0 - time / 60.0)
  end
end
