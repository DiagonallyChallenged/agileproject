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

    it 'should be able to move horizonally' do
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

  describe 'queen' do
    it 'it should return true for valid moves' do
      game = Game.create
      piece = Piece.create(x: 4, y: 4, type: 'Queen', game: game)
      valid_moves = [[5, 4], [3, 4], [4, 5], [4, 3], [3, 3]]

      valid_moves.each do |(x, y)|
        expect(piece.valid_move?(x, y)).to be true
      end
    end

    it 'it should return false for invalid moves' do
      game = Game.create
      piece = Piece.create(x: 4, y: 4, type: 'Queen', game: game)
      invalid_moves = [[5, 1]]

      invalid_moves.each do |(x, y)|
        expect { piece.valid_move?(x, y) }.to raise_error('Invalid Move')
      end
    end
  end
end
