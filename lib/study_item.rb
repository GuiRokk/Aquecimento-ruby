require 'colorize'
class StudyItem

    attr_reader :id, :title, :category
    attr_accessor :done
    @@next_id = 1
    @@item_collection = []
    
    def initialize(title:, category:, done:"x")
        @id = @@next_id
        @title = title
        @category = category 
        @done = done

        @@next_id += 1
        @@item_collection << self
    end

    def self.all_done?
        items_done = @@item_collection.map do |item|
            item.is_done?
        end
        if items_done.include? false
            false
        else
            true
        end    
    end

    def self.mark_done
        if @@item_collection.empty?
            puts 'Nenhum item cadastrado'
        else
            if StudyItem.all_done?
                puts "Parabens! Você concluiu todos os itens!"
            else
                puts StudyItem.print_item
                puts "Qual o ID do item quer marcar feito?"
                id = gets.to_i
                item_index = StudyItem.all.find_index do |item|
                    item.id == id
                end
                if item_index.nil?
                    puts 'ID Inválido'
                else
                    StudyItem.all[item_index].done = 'V'
                end
            end
        end
    end

    def is_done?
        if @done == 'V'
            true
        else
            false
        end
    end

    def include?(query)
        title.downcase.include?(query.downcase) || category.downcase.include?(query.downcase)
    end

    def to_s
        "[#{done}] ##{id} - #{title} - #{category}"
    end

    def self.register
        print 'Digite o título do seu item de estudo: '
        title = gets.chomp
        print 'Digite a categoria do seu item de estudo: '
        category = gets.chomp
        puts "Item '#{title}' da categoria '#{category}' cadastrado com sucesso!"
        new(title:title, category: category)
    end

    def self.all
        @@item_collection
    end

    def self.print_item(collection: @@item_collection)
            collection.each do |item|
                if item.is_done?
                    puts "#{item.to_s}".green
                else
                    puts "#{item.to_s}".red
                end
            end
        puts 'Nenhum item cadastrado' if collection.empty?
    end

    def self.search
        if StudyItem.all.empty?
            puts 'Nenhum item cadastrado'
        else
            puts 'Digite uma palavra para procurar:'
            term = gets.chomp
            found_items =  StudyItem.all.filter do |item|
                item.include?(term)
            end
            StudyItem.print_item(collection:found_items)
        end
    end


    def self.delete
        if StudyItem.all.empty?
            puts 'Nenhum item cadastrado'
        else
            puts StudyItem.print_item
            puts "Qual o ID do item quer deletar?"
            id = gets.to_i
            item_index = StudyItem.all.find_index do |item|
                item.id == id
            end
            deleted_item = []
            deleted_item <<  StudyItem.all[item_index]
            puts "Item:"
            StudyItem.print_item(collection:deleted_item)} 
            puts "deletado"
            StudyItem.all.delete_at(item_index)
        end
    end






end