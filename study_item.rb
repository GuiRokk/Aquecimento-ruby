class StudyItem

    attr_reader :title, :category, :done

    def initialize(title, category, done:"x")
        @title = title
        @category = category 
        @done = done
    end


    def check_done()
        @done = "V"
    end

    def is_done?()
        if @done == "V"
            true
        else
            false
        end
    end
end