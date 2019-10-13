module GamesHelper
  def render_piece(pieces, x, y)
    piece = pieces.find { |pc| pc[:x_location] == x and pc[:y_location] == y }
    if piece
      piece[:type]
    end
  end

  def black_or_white(x, y)
    if y.odd?
      if x.odd?
        'white'
      else
        'black'
      end
    else
      if x.odd?
        'black'
      else
        'white'
      end
    end
  end
end
