require 'pry'

class Room 

	attr_reader :id, :doors, :setting, :food, :inventory

	# Assigning the values of each room. 
	def initialize(id, doors, setting, food, inventory)
		@id = id
		@doors = doors
		@setting = setting
		@food = food
		@inventory = inventory	
	end
end

class Game
	def initialize
		@rooms = []
		@current = 0
		@player_inventory = []
		@input = ""
	end

	def add_rooms(room)
		@rooms.push(room)
		@rooms.sort_by { |room| room.id }
	end

	def describe_room
		puts "You are in a #{@rooms[@current].setting}. Choose what to do."
		
		unless @rooms[@current].inventory == "" || @player_inventory.include?(@rooms[@current].inventory)
			puts "You can see a #{@rooms[@current].inventory}."
		end

		puts "Exits: #{@rooms[@current].doors.join(", ")}"
		puts "<"
		self.ask_for_input
	end

	def ask_for_input
		@input = gets.chomp
		self.what_did_the_player_enter
	end

	def what_did_the_player_enter
		@cap_input = @input.upcase
		@last_word_input = @input.split.last 

		if @cap_input.include?("pick".upcase) || @cap_input.include?("drop".upcase)
			self.input_is_inventory
		elsif @rooms[@current].doors.include?(@cap_input) 
			self.input_is_direction
		elsif @cap_input == "inventory".upcase
			show_inventory
		elsif @cap_input == "exit".upcase
			self.exit_game
		else
			self.input_is_no_command
		end
	end

	def input_is_inventory

		if @cap_input == "Pick up #{@rooms[@current].inventory}".upcase 
			puts "You picked up the #{@rooms[@current].inventory}."
			@player_inventory.push(@rooms[@current].inventory)
			puts "The inventory is #{@player_inventory}"
			self.ask_for_next_play
		elsif @player_inventory.include?("#{@last_word_input}")
			puts "You dropped the #{@last_word_input}."
			@player_inventory.delete(@last_word_input)
			#change replace to "add to" the current inventory
			@rooms[@current].inventory.replace(@last_word_input)
			puts "The inventory is #{@player_inventory}"
			self.ask_for_next_play	
		else 
			puts "error1"
		end

	end

	def input_is_direction
	
		if @cap_input == "N"
			@current = @current + 1
			self.ask_for_next_play	
		elsif @cap_input == "S"
			@current = @current - 1
			self.ask_for_next_play	
		elsif @cap_input == "W" && @current == 2
			@current = 4
			self.ask_for_next_play	
		elsif @cap_input == "E" && @current == 2
			@current = 5
			self.ask_for_next_play					
		elsif @cap_input == "E" && @current == 4
			@current = 2
			self.ask_for_next_play					
		elsif @cap_input == "W" && @current == 5
			@current = 2
			self.ask_for_next_play					
		else 
			puts "error2"
		end

	end

	def input_is_no_command
		puts "try again"
		self.ask_for_input
	end

	def show_inventory
		puts "The inventory is #{@player_inventory}"
		self.ask_for_next_play					
	end


	def ask_for_next_play
		self.describe_room
	end

	def exit_game
	end

end

room1 = Room.new(0, ["N"], "forest", true, "sword")
room2 = Room.new(1, ["N", "S"], "city", false, "")
room3 = Room.new(2, ["N", "S", "E", "W"], "church", false, "")
room4 = Room.new(3, ["S"], "house", false, "")
room5 = Room.new(4, ["E"], "bar", false, "")
room6 = Room.new(5, ["W"], "restaurant", false, "")

my_game = Game.new
my_game.add_rooms(room1)
my_game.add_rooms(room2)
my_game.add_rooms(room3)
my_game.add_rooms(room4)
my_game.add_rooms(room5)
my_game.add_rooms(room6)

my_game.describe_room


