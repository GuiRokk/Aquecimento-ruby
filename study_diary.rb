require_relative './study_item.rb'

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
    'Bem-vindo ao Diário de Estudos, seu companheiro para estudar!'
end
  
def menu
    puts "[1] Cadastrar um item para estudar"
    puts "[2] Ver todos os itens cadastrados"
    puts "[3] Buscar um item de estudo"
    puts "[4] Sair"
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
        puts "##{index + 1} - #{item.title} - #{item.category}"
    end
    puts 'Nenhum item cadastrado' if collection.empty?
end

def search_item(collection)
    print 'Digite uma palavra para procurar: '
    term = gets.chomp
    found_items = collection.filter do |item|
        item.title.include? term
    end
    print_item(found_items)
    puts 'Nenhum item encontrado' if collection.empty?
end

clear
puts welcome
study_items = []
option = menu
  
loop do
    clear
    case option
    when 1
        study_items << register_study_item
    when 2
        print_item(study_items)
    when 3
        search_item(study_items)
    when 4
        clear
        puts 'Obrigado por usar o Diário de Estudos'  
        break
    else
        puts 'Opção inválida'
    end
    wait_keypress_and_clear
    option = menu
end