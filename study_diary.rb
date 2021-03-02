require_relative './study_item.rb'
require 'colorize'

def clear
    system('clear')
end

def wait_keypress
    puts
    puts 'Pressione qualquer tecla para continuar'
    gets
end

def wait_keypress_and_clear
    wait_keypress
    clear
end

def welcome
    '<<< Bem-vindo ao Diário de Estudos, seu companheiro para estudar! >>>'
end
  
def menu
    cadastro = 1
    exibir =   2
    concluir = 3
    buscar =   4
    limpar =   5
    sair =     6
    puts "[#{cadastro}] Cadastrar um item para estudar"
    puts "[#{exibir}] Ver todos os itens cadastrados"
    puts "[#{concluir}] Concluir um item"
    puts "[#{buscar}] Buscar um item de estudo"
    puts "[#{limpar}] Apagar item"
    puts "[#{sair}] Sair"
    print 'Escolha uma opção: '
    gets.to_i
end
  
def register_study_item
    print 'Digite o título do seu item de estudo: '
    title = gets.chomp
    print 'Digite a categoria do seu item de estudo: '
    category = gets.chomp
    puts "Item '#{title}' da categoria '#{category}' cadastrado com sucesso!"
    StudyItem.new(title, category)
end

def print_item(collection)
    collection.each_with_index do |item, index|
        print_output = "[#{item.done}] ##{index + 1} - #{item.title} - #{item.category}"
        if item.is_done?
            puts print_output.green
        else
            puts print_output.red
        end
    end
    puts 'Nenhum item cadastrado' if collection.empty?
end

def search_item(collection)
    if collection.empty?
        puts 'Nenhum item cadastrado'
    else
        print 'Digite uma palavra para procurar: '
        term = gets.chomp    
        found_items = collection.filter do |item|
            item.title.include? term or item.category.include? term
        end
        print_item(found_items)
    end
end

def all_done?(collection)
    items = collection.map do |item|
        item.is_done?
    end
    if items.include? false
        false
    else
        true
    end
end

def check_done(collection)
    if collection.empty?
        puts 'Nenhum item cadastrado'
    else
        if all_done?(collection)
            puts "Parabéns! Você concluiu todos os itens!"
        else
            puts "Qual item você concluiu?"
            print_item(collection)
            index = gets.chomp.to_i
            if index == 0
                clear
                puts "Função Abortada" 
            else
                item = collection[index-1]
                item.check_done
                clear
                puts "[#{item.done}] ##{index} - #{item.title} - #{item.category}".green
                puts "Siga em frente com seus estudos!"
            end             
        end
    end
end    

def delete_item(collection)
    if collection.empty?
        puts 'Nenhum item cadastrado'
    else
        puts "Qual item quer apagar?"
        print_item(collection)
        index = gets.chomp.to_i
        deleted_item = "##{index} >> #{collection[index-1].title} - #{collection[index-1].category}"
        clear
        puts "Item #{deleted_item} apagado com sucesso..."
        collection.delete_at(index)
    end
end

clear
puts welcome
study_items = []
option = menu
  
loop do
    clear
    case option
    when 1 #adciona
        study_items << register_study_item
    when 2 #exibe
        print_item(study_items)
    when 3 #marca concluído
        check_done(study_items)   
    when 4 #Procura item
        search_item(study_items)
    when 5 #Limpa item
        delete_item(study_items)
    when 6 #Sair
        clear
        puts 'Obrigado por usar o Diário de Estudos'  
        break
    else
        puts 'Opção inválida'
    end
    wait_keypress_and_clear
    option = menu
end