require 'rails_helper'

RSpec.describe 'movement logic' do
  describe 'king' do
    it 'should be able to move one square' do
      piece = Piece.create(x: 5, y: 1, type: 'King')
      new_location = {
        x_des: piece.x,
        y_des: piece.y + 1
      }
      expect(piece.valid_move?(new_location)).to eq(true)
    end

    it 'should not be able to move two squares vertically' do
      game = Game.create
      piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
      new_location = {
        x_des: piece.x,
        y_des: piece.y + 2
      }
      expect(piece.valid_move?(new_location)).to eq(false)
    end

    it 'should not be able to move two squares diagonally' do
      game = Game.create
      piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
      new_location = {
        x_des: piece.x + 2,
        y_des: piece.y + 2
      }
      expect(piece.valid_move?(new_location)).to eq(false)
    end

    it 'should not be able to move two squares horizonally' do
      game = Game.create
      piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
      new_location = {
        x_des: piece.x + 2,
        y_des: piece.y
      }
      expect(piece.valid_move?(new_location)).to eq(false)
    end

    it 'should be able to move backwards' do
      piece = Piece.create(x: 5, y: 1, type: 'King')
      new_location = {
        x_des: piece.x,
        y_des: piece.y - 1
      }
      expect(piece.valid_move?(new_location)).to eq(true)
    end

    it 'should be able to move diagonally' do
      game = Game.create
      piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
      new_location = {
        x_des: piece.x + 1,
        y_des: piece.y + 1
      }
      expect(piece.valid_move?(new_location)).to eq(true)
    end

    it 'should be able to move horizontally' do
      piece = Piece.create(x: 5, y: 1, type: 'King')
      new_location = {
        x_des: piece.x + 1,
        y_des: piece.y
      }
      expect(piece.valid_move?(new_location)).to eq(true)
    end
  end

  describe 'knight' do
    it 'it should return true for all eight valid moves' do
      piece = Piece.create(x: 4, y: 4, type: 'Knight')
      valid_moves = [[6, 5], [6, 3], [2, 5], [2, 3], [5, 6], [3, 6], [5, 2], [3, 2]]

      valid_moves.each do |valid_move|
        new_location = {
          x_des: valid_move[0],
          y_des: valid_move[1]
        }

        expect(piece.valid_move?(new_location)).to be true
      end
    end

    it 'should return true if move is not valid for knight' do
      piece = Piece.create(x: 4, y: 4, type: 'Knight')
      invalid_moves = [[1, 1], [4, 7], [1, 4], [3, 3]]

      invalid_moves.each do |invalid_move|
        new_location = {
          x_des: invalid_move[0],
          y_des: invalid_move[1]
        }

        expect(piece.valid_move?(new_location)).to be false
      end
    end
  end

  describe 'Pawn' do
    it 'white pawns should be able to move up but not down' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 5, y: 2, type: 'Pawn', game: game, user: game.white_player)
      new_location = {
        x_des: piece.x,
        y_des: piece.y + 1
      }

      new_location2 = {
        x_des: piece.x,
        y_des: piece.y - 1
      }
      expect(piece.valid_move?(new_location)).to be true
      expect(piece.valid_move?(new_location2)).to be false
    end

    it 'black pawns should be able to move down but not up' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.join_game(user, 'black')
      game.save

      piece = Piece.create(x: 5, y: 7, type: 'Pawn', game: game, user: game.black_player)
      new_location = {
        x_des: piece.x,
        y_des: piece.y - 1
      }

      new_location2 = {
        x_des: piece.x,
        y_des: piece.y + 1
      }
      expect(piece.valid_move?(new_location)).to be true
      expect(piece.valid_move?(new_location2)).to be false
    end

    it 'should only be able to move twice from its starting position' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 5, y: 2, type: 'Pawn', game: game, user: game.white_player)
      new_location = {
        x_des: piece.x,
        y_des: piece.y + 2
      }

      piece2 = Piece.create(x: 5, y: 3, type: 'Pawn', game: game, user: game.white_player)
      new_location2 = {
        x_des: piece2.x,
        y_des: piece2.y + 2
      }

      expect(piece.valid_move?(new_location)).to be true
      expect(piece2.valid_move?(new_location2)).to be false
    end

    it 'should not allow horizontal movement' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 5, y: 2, type: 'Pawn', game: game, user: game.white_player)
      new_location = {
        x_des: piece.x - 1,
        y_des: piece.y
      }
      expect(piece.valid_move?(new_location)).to be false
    end

    it 'should only allow diagonal movement if capturing' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 5, y: 2, type: 'Pawn', game: game, user: game.white_player)
      user = FactoryBot.create(:user)
      game.join_game(user, 'black')
      game.save

      Piece.create(x: 6, y: 3, type: 'Pawn', game: game, user: game.black_player)

      new_location = {
        x_des: piece.x + 1,
        y_des: piece.y + 1
      }

      new_location2 = {
        x_des: piece.x - 1,
        y_des: piece.y + 1
      }

      expect(piece.valid_move?(new_location)).to be true
      expect(piece.valid_move?(new_location2)).to be false
    end
  end

  describe 'Queen' do
    it 'should return true for valid moves' do
      game = Game.create
      piece = Piece.create(x: 4, y: 4, type: 'Queen', game: game)
      valid_moves = [[5, 4], [3, 4], [4, 5], [4, 3], [3, 3]]

      valid_moves.each do |(x, y)|
        new_location = {
          x_des: x,
          y_des: y
        }

        expect(piece.valid_move?(new_location)).to be true
      end
    end

    it 'it should return false for invalid moves' do
      game = Game.create
      piece = Piece.create(x: 4, y: 4, type: 'Queen', game: game)
      invalid_moves = [[5, 1]]

      invalid_moves.each do |(x, y)|
        new_location = {
          x_des: x,
          y_des: y
        }

        expect { piece.valid_move?(new_location) }.to raise_error('Invalid Move')
      end
    end
  end

  describe 'Bishop' do
    it 'should return true if all moves are valid moves' do
      game = Game.create
      piece = Piece.create(x: 3, y: 1, type: 'Bishop', game: game)
      valid_moves = [[1, 3], [2, 2], [4, 2], [5, 3], [6, 4], [7, 5], [8, 6]]

      expect(valid_moves).to all(satisfy('be a valid move') do |valid_move|
        new_location = {
          x_des: valid_move[0],
          y_des: valid_move[1]
        }

        piece.valid_move?(new_location) == true
      end)
    end

    it 'should return false if move is not valid for bishop' do
      game = Game.create
      piece = Piece.create(x: 3, y: 1, type: 'Bishop', game: game)
      invalid_moves = [[4, 1], [2, 1], [3, 2]]

      expect(invalid_moves).to all(satisfy('be a invalid move') do |invalid_move|
        new_location = {
          x_des: invalid_move[0],
          y_des: invalid_move[1]
        }

        piece.valid_move?(new_location) == false
      end)
    end
  end

  describe 'rook' do
    it 'it should return true for all horizontal moves' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 4, y: 4, type: 'Rook', game: game)
      valid_moves = [[3, 4], [2, 4], [1, 4], [5, 4], [6, 4], [7, 4], [8, 4]]

      valid_moves.each do |valid_move|
        new_location = {
          x_des: valid_move[0],
          y_des: valid_move[1]
        }

        expect(piece.valid_move?(new_location)).to be true
      end
    end

    it 'it should return true for all vertical moves' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 4, y: 4, type: 'Rook', game: game)
      valid_moves = [[4, 3], [4, 2], [4, 1], [4, 5], [4, 6], [4, 7], [4, 8]]

      valid_moves.each do |valid_move|
        new_location = {
          x_des: valid_move[0],
          y_des: valid_move[1]
        }

        expect(piece.valid_move?(new_location)).to be true
      end
    end

    it 'should return false if move is not valid for Rook' do
      game = FactoryBot.create(:game)
      piece = Piece.create(x: 4, y: 4, type: 'Rook', game: game)
      invalid_moves = [[1, 1], [5, 5], [3, 5], [5, 3]]

      invalid_moves.each do |invalid_move|
        new_location = {
          x_des: invalid_move[0],
          y_des: invalid_move[1]
        }

        expect(piece.valid_move?(new_location)).to be false
      end
    end
  end
end
