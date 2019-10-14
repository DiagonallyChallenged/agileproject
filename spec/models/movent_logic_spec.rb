require 'rails_helper'

RSpec.describe 'movement logic' do
	describe 'king' do
		it 'should be able to move one square' do
			piece = Piece.create(x: 1, y: 1, type: 'King')
			new_location = {
				x: piece.x,
				y: piece.y + 1
			}
			expect( piece.valid_move?(new_location) ).to eq(true)
		end

		it 'should not be able to move backwards' do
			piece = Piece.create(x: 1, y: 1, type: 'Pawn')
			new_location = {
				x: piece.x,
				y: piece.y - 1
			}
			expect( piece.valid_move?(new_location) ).to eq(false)
		end

		it 'should not be able to move diagonally when the new location is empty' do
			piece = Piece.create(x: 1, y: 1, type: 'Pawn')
			new_location = {
				x: piece.x + 1,
				y: piece.y + 1
			}
			expect( piece.valid_move?(new_location) ).to eq(false)
		end

		it 'should be able to move diagonally if an enemy is in the square' do
			piece = Piece.create(x: 1, y: 1, type: 'Pawn')
			new_location = {
				x: piece.x + 1,
				y: piece.y + 1
			}
			enemy_piece = Piece.create(**new_location, type: 'Pawn')
			expect( piece.valid_move?(new_location) ).to eq(true)
		end


		it "when new location contains a friendly piece" do
		end
	end
	
end
