class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_reader :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  def guess(letter)
    raise ArgumentError unless letter.match?(/[a-zA-Z]/)
    letter = letter.downcase
    if guesses.include?(letter) or wrong_guesses.include?(letter)
      return false
    end
    if word.include?(letter)
      # add letter to the guess list
      @guesses.concat(letter)
      return true
    end
    # add letter to wrong guess string
    @wrong_guesses << letter
    true
  end
  def check_win_or_lose
    if wrong_guesses.length >= 7
      return :lose
    elsif !word_with_guesses.match?(/[-]/)
      return :win
    else
      :play
    end
  end
  def word_with_guesses

  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
