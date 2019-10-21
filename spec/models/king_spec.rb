require 'rails_helper'

RSpec.describe King do
  describe 'valid_move?' do

    context 'when a piece is in the way' do
      it 'should return false' do
        game = Game.create
        king = Piece.create(x: 5, y: 1, type: 'King', game: game)
        pawn = Piece.create(x: 5, y: 2, type: 'Pawn', game: game)
        new_location = {
          x_des: king.x,
          y_des: king.y + 1
        }
        expect(king.valid_move?(new_location)).to be false
      end
    end
    context 'when it moves one square forward' do 
      it 'should return true' do
        piece = Piece.create(x: 5, y: 1, type: 'King')
        new_location = {
          x_des: piece.x,
          y_des: piece.y + 1
        }
        expect(piece.valid_move?(new_location)).to eq(true)
      end
    end

    context 'when moving two squares vertically' do
      it 'should return false' do
        game = Game.create
        piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
        new_location = {
          x_des: piece.x,
          y_des: piece.y + 2
        }
        expect(piece.valid_move?(new_location)).to eq(false)
      end
    end

    context 'when moving two squares diagonally' do
      it 'should return false' do
        game = Game.create
        piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
        new_location = {
          x_des: piece.x + 2,
          y_des: piece.y + 2
        }
        expect(piece.valid_move?(new_location)).to eq(false)
      end
    end

    context 'when moving two squares horizonally' do
      it 'should return false' do
        game = Game.create
        piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
        new_location = {
          x_des: piece.x + 2,
          y_des: piece.y
        }
        expect(piece.valid_move?(new_location)).to eq(false)
      end
    end

    context 'when moving backwards one square' do
      it 'should true true' do
        piece = Piece.create(x: 5, y: 1, type: 'King')
        new_location = {
          x_des: piece.x,
          y_des: piece.y - 1
        }
        expect(piece.valid_move?(new_location)).to eq(true)
      end
    end

    context 'when moving one square diagonally' do
      it 'should return true' do
        game = Game.create
        piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
        new_location = {
          x_des: piece.x + 1,
          y_des: piece.y + 1
        }
        expect(piece.valid_move?(new_location)).to eq(true)
      end
    end

    context 'when moving one square horizonally' do
      it 'should return true' do
        piece = Piece.create(x: 5, y: 1, type: 'King')
        new_location = {
          x_des: piece.x + 1,
          y_des: piece.y
        }
        expect(piece.valid_move?(new_location)).to eq(true)
      end
    end
  end
end
