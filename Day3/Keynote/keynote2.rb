require 'terminfo'

class DBOperations
  attr_accessor :slide_text

    def read_text_from_file
      @arr = IO.read("slides.txt")
      split_the_read_text_into_array
    end

    def split_the_read_text_into_array
      @arr.split("\n----\n").to_a
    end
end

class Presenter

  def initialize(slide_text)
    @slide_text = slide_text
    @slide_number = 0
  end

  def create_empty_lines
    i = 1
    num = 12
      while i < num  do
        puts""
        i +=1
      end
  end

  def create_center_line
    @slide_text[@slide_number].center(80, " ")
  end

  def create_a_slide
    # I can't get rid of the puts somehow
    puts create_empty_lines
    puts create_center_line
    puts create_empty_lines
    change_slide_number
  end

  def change_slide_number
    sleep 3

    #length is supposed to count the number of items in the array
    if @slide_number < @slide_text.count
      @slide_number = @slide_number + 1
    else
      return "The end"
    end

    create_a_slide
  end
end

slide_text = DBOperations.new.read_text_from_file
presentation = Presenter.new(slide_text)

presentation.create_a_slide