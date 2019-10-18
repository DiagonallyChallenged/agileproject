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

    it 'shoud not be able to move two squares vertically' do
      game = Game.create
      piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
      new_location = {
        x_des: piece.x,
        y_des: piece.y + 2
      }
      expect(piece.valid_move?(new_location)).to eq(false)
    end

    it 'shoud not be able to move two squares diagonally' do
      game = Game.create
      piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
      new_location = {
        x_des: piece.x + 2,
        y_des: piece.y + 2
      }
      expect(piece.valid_move?(new_location)).to eq(false)
    end

    it 'shoud not be able to move two squares horizonally' do
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
    it 'should NOT check for obstructions and return true for valid move' do
      piece = Piece.create(x: 1, y: 1, type: 'Knight')
      new_location = {
        x_des: piece.x + 2,
        y_des: piece.y + 1
      }

      Piece.create(x: 2, y: 1, type: 'Knight')
      expect(piece.valid_move?(new_location)).to be true
    end

    it 'should return true if move is not valid for knight' do
      piece = Piece.create(x: 1, y: 1, type: 'Knight')
      new_location = {
        x_des: piece.x + 1,
        y_des: piece.y
      }

      expect(piece.valid_move?(new_location)).to be false
    end

    it 'should return false if spot is off the board' do
      piece = Piece.create(x: 1, y: 1, type: 'Knight')
      new_location = {
        x_des: piece.x - 1,
        y_des: piece.y - 2
      }
      expect(piece.valid_move?(new_location)).to be false
    end
  end
end
