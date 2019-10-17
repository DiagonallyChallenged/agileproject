require 'rails_helper'

RSpec.describe 'movement logic' do
	describe 'king' do
		it 'should be able to move one square' do
			piece = Piece.create(x: 5, y: 1, type: 'King')
			new_location = {
				x: piece.x,
				y: piece.y + 1
			}
			expect( piece.valid_move?(new_location) ).to eq(true)
		end

		it 'should be able to move backwards' do
			piece = Piece.create(x: 5, y: 1, type: 'King')
			new_location = {
				x: piece.x,
				y: piece.y - 1
			}
			expect( piece.valid_move?(new_location) ).to eq(true)
		end

		it 'should be able to move diagonally' do
			game = Game.create
			piece = Piece.create(x: 5, y: 1, type: 'King', game: game)
			new_location = {
				x: piece.x + 1,
				y: piece.y + 1
			}
			expect( piece.valid_move?(new_location) ).to eq(true)
		end

		it 'should be able to move horizonally' do
			piece = Piece.create(x: 5, y: 1, type: 'King')
			new_location = {
				x: piece.x + 1,
				y: piece.y
			}
			expect( piece.valid_move?(new_location) ).to eq(true)
		end

		#it 'should be able to move diagonally if an enemy is in the square' do
		#	piece = Piece.create(x: 5, y: 1, type: 'King')
		#	new_location = {
		#		x: piece.x + 1,
		#		y: piece.y + 1
		#	}
		#	enemy_piece = Piece.create(**new_location, type: 'King')
		#	expect( piece.valid_move?(new_location) ).to eq(true)
		#end


		#it "when new location contains a friendly piece" do
		#end
	end
	
end
