require 'sinatra'
require 'sinatra/reloader' if development?

get '/'  do
  text = params["text"]
  shift = params["shift"].to_i

  text_to_render = ""

  if params[:encryption] == "cipher"
    text_to_render = cipher(text, shift)
  else 
    text_to_render = decipher(text, shift)
    puts alphabet = ("a".."z").to_a[25]
  end

  erb :index, locals: {text: text_to_render}
end

def cipher(str, shift)
  
  alphabet = ("a".."z").to_a
  alphabet_up = ("A".."Z").to_a
  
  letters = str.split("")
  
  final = []
  
  letters.each do |letter|
    if letter.is_upper?
      if alphabet_up.index(letter) == NIL
        final << letter
      elsif alphabet_up.index(letter) >= shift
        final << alphabet_up[alphabet_up.index(letter) - shift]
      else 
        final << alphabet_up[26 - shift + alphabet_up.index(letter)]
      end
    else
      if alphabet.index(letter) == NIL
        final << letter
      elsif alphabet.index(letter) >= shift
        final << alphabet[alphabet.index(letter) - shift]
      else 
        final << alphabet[26 - shift + alphabet.index(letter)]
      end
    end
  end
  final.reduce(:concat)
end

def decipher(str, shift)
  
  alphabet = ("a".."z").to_a
  alphabet_up = ("A".."Z").to_a
  
  letters = str.split("")
  
  final = []
  
  letters.each do |letter|
    if letter.is_upper?
      if alphabet_up.index(letter) == NIL
        final << letter
      elsif alphabet_up.index(letter) + shift < 26
        final << alphabet_up[alphabet_up.index(letter) + shift]
      else 
        final << alphabet_up[shift + alphabet_up.index(letter) - 26]
      end
    else
      if alphabet.index(letter) == NIL
        final << letter
      elsif alphabet.index(letter) + shift < 26
        final << alphabet[alphabet.index(letter) + shift]
      else 
        final << alphabet[shift + alphabet.index(letter) - 26]
      end
    end
  end
  final.reduce(:concat)
end

class String
  def is_upper?
    self == self.upcase
  end

  def is_lower?
    self == self.downcase
  end
end