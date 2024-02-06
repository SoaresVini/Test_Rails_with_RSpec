namespace :dev do
  desc 'Recriando o banco'
  task setup: :environment do
    puts 'Resetando o Banco......'
    %x(rails db:drop) 
    puts 'Criando o Banco......'
    %x(rails db:create) 
    puts 'Migrando o Banco......'
    %x(rails db:migrate)

    puts '[Finalizado]'
  end
end
