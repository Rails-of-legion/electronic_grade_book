FROM ruby:3.0.0

# Устанавливаем Node.js и Yarn для управления зависимостями JavaScript
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Создаем и используем рабочую директорию
WORKDIR /app

# Копируем файл Gemfile и Gemfile.lock в контейнер
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Устанавливаем зависимости приложения
RUN bundle install

# Копируем все файлы проекта в контейнер
COPY . /app

# Настройка прав на исполняемые файлы
RUN chmod +x bin/rails

# Открываем порт для приложения
EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
