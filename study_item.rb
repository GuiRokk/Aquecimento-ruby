class StudyItem

    attr_reader :title, :category
    attr_accessor :done


    def initialize(title, category, done:"x")
        @title = title
        @category = category 
        @done = done
    end
end