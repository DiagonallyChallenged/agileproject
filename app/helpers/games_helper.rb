module GamesHelper
  # def print_piece(pieces, x, y)
  #   piece = pieces.find { |pc| pc[:pos_x] == x and pc[:pos_y] == y }
  #   if piece
  #     piece[:type]
  #   end
  # end

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
