require_relative 'study_item'

REGISTER = 1
VIEW     = 2
CHECKBOX = 3
SEARCH   = 4
DELETE   = 5
EXIT     = 6

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
 
    puts "[#{REGISTER}] Cadastrar um item para estudar"
    puts "[#{VIEW}] Ver todos os itens cadastrados"
    puts "[#{CHECKBOX}] Concluir um item"
    puts "[#{SEARCH}] Buscar um item de estudo"
    puts "[#{DELETE}] Apagar item"
    puts "[#{EXIT}] Sair"
    print 'Escolha uma opção: '
    gets.to_i
end

#BUGADO
def delete_item(collection)
    if StudyItem.all.empty?
        puts 'Nenhum item cadastrado'
    else
        puts "Qual item quer apagar?"
        print_item(collection)
        index = gets.chomp.to_i
        item = collection[index-1]
        deleted_item = "##{item.id} >> #{item.title} - #{item.category}"
        p collection
        #clear
        puts "Item #{deleted_item} apagado com sucesso..."
        collection.delete_at(item.id)
    
    #detect/find

    #study_item =  StudyItem.all.find do |item|
    #    study_item.id == id
    #end
    #StudyItem.all.delete(study_item)
    
    end
end

clear
puts welcome
study_items = []
option = menu

loop do
    clear
    case option
    when REGISTER 
       StudyItem.register
    when VIEW 
       StudyItem.print_item
    when CHECKBOX 
       StudyItem.mark_done   
    when SEARCH 
        StudyItem.search
    when DELETE 
        StudyItem.delete
    when EXIT 
        clear
        puts 'Obrigado por usar o Diário de Estudos'  
        break
    else
        puts 'Opção inválida'
    end
    wait_keypress_and_clear
    option = menu
end



#bundle init


#gem "sqlite3"

#require sqlite3

#ler json, gravar em json

#um jeito de gravar quando ele fecha
#ler quando ele carrega

#require sqlite3
#  #!/usr/bin/env ruby
#    puts '===instalando dependencias ==='
#    system('bundle install')

#db  = SQLite3::Database.new "study_diary.db"

#create table
#rows = db.execute <<-SQL
#    create table if not exists study_items (
#        id integer primary key autoincremente,
#        tittle text,
#        category text,       
    #);
    #SQL


    # bin exetcutavel
    #chmod +x bin/setup
