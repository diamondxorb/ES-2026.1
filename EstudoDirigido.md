<center>

### Universidade de Brasília
#### Instituto de Ciências Exatas
#### Departamento de Ciência da Computação
#### Engenharia de Software - 2026.1

![UnB](unb.png)

# Como LLM pode promover o aprendizado e o desenvolvimento de aplicações Ruby?

#### Júlia Paulo Amorim - 241039270

</center>

- Link para o repositório da atividade: [ES-2026.1](https://github.com/diamondxorb/ES-2026.1)

## 1. Resolução dos exercícios

A resolução de todos os exercícios pode ser encontrada na pasta [HW1](https://github.com/diamondxorb/ES-2026.1/tree/main/HW1) do repositório.

## 2. Explicação das estruturas

### Part 1: fun with strings

```ruby
def palindrome?(string)
  answer = string.downcase
  answer = answer.gsub(/\W/, "")
  answer == answer.reverse
end
```
- Manipulação de Strings: métodos como downcase - tudo para o minúsculo, gsub (com regex), reverse - inverte a string.
- Regex: Expressões regulares como (/\W/) para limpeza dos caracteres que não são considerados palavras.

```ruby
def count_words(string)
  words = string.downcase.scan(/\b[\w]+/)
  words.each_with_object(Hash.new(0)) { 
    |word, counts| counts[word] += 1 
  }
end
```
- Estruturas de Dados: Hash criado com `each_with_object` para contagem de palavras, arrays implícitos.


### Part 2: Rock-Paper-Scissors

```ruby
def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  p1_name, p1_strat = game[0]
  p2_name, p2_strat = game[1]

  p1_strat = p1_strat.upcase
  p2_strat = p2_strat.upcase

  valid_strats = ["R", "P", "S"]
  raise NoSuchStrategyError unless valid_strats.include?(p1_strat) && valid_strats.include?(p2_strat)

  win = {
    "R" => "S",
    "S" => "P",
    "P" => "R"
  }

  if p1_strat == p2_strat || win[p1_strat] == p2_strat
    return game[0]
  else
    return game[1]
  end
end
```
- Estruturas de Controle: raise para lançar exceções, condicionais (if/else) e hash para lógica de vitória.
- Arrays e Destructuring: Acesso a arrays aninhados e desestruturação como na parte: p1_name, p1_strat = game[0].

```ruby
def rps_tournament_winner(tournament)
  if tournament.length == 2 && tournament.all? { |player| player.is_a?(Array) && player.length == 2 && player[0].is_a?(String) }
    return rps_game_winner(tournament)
  end
  
  left_winner = rps_tournament_winner(tournament[0])
  right_winner = rps_tournament_winner(tournament[1])
  
  rps_game_winner([left_winner, right_winner])
end
```
- Recursão: Chamadas recursivas em `rps_tournament_winner` para processar torneios.


### Part 3: anagrams

```ruby
def combine_anagrams(words)
  words.group_by { |word| word.downcase.chars.sort.join }.values
end
```
- Manipulação de Arrays: `group_by` com bloco para agrupar palavras por anagramas.
- Manipulação de Strings: downcase, chars, sort, join para normalizar e ordenar caracteres.


### Part 4: Basic OOP

```ruby
class Dessert
  attr_accessor :name, :calories

  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  def healthy?
    @calories < 200
  end

  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_accessor :flavor

  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end

  def delicious?
    @flavor != "black licorice"
  end
end
```
- Classes e Herança: Dessert como classe base, JellyBean herda dela com super no initialize.
- Atributos: attr_accessor para getters/setters automáticos.
- Métodos: Métodos de instância como healthy? e delicious?, sendo sobrescrito na subclasse.


### Part 5: advanced OOP, metaprogramming, open classes and duck typing

```ruby
class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s
    attr_reader attr_name
    attr_reader attr_name+"_history"
    
  class_eval %Q{
    def #{attr_name}=(value)
      @#{attr_name}_history ||= [nil]
      @#{attr_name}_history << value
      @#{attr_name} = value
    end

    def #{attr_name}_history
      @#{attr_name}_history || [nil]
    end
  }
  end
end
```
- Metaprogramação: Monkey patch na classe Class com attr_accessor_with_history.
- Métodos Dinâmicos: class_eval com string interpolation (%Q{}) para definir métodos dinamicamente.
- Variáveis de Instância: Uso de @ para armazenar histórico em arrays.


### Part 6: advanced OOP, metaprogramming, open classes and duck typing, continued

```ruby
class Numeric
  @@currencies = {"dollar" => 1.0, "yen" => 0.013, "euro" => 1.292, "rupee" => 0.019}
  
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub(/s$/, "")
    
    if @@currencies.has_key?(singular_currency)
      Currency.new(self * @@currencies[singular_currency], singular_currency)
    else
      super
    end
  end

  def in(target_currency)
    singular_target = target_currency.to_s.gsub(/s$/, "")

    if @@currencies.has_key?(singular_target)
      if self.is_a?(Currency)
        self.value / @@currencies[singular_target]
      else
        self / @@currencies[singular_target]
      end
    else
      super
    end
  end
end

class Currency
  attr_reader :value, :currency

  def initialize(value, currency)
    @value = value
    @currency = currency
  end

  def in(target_currency)
    singular_target = target_currency.to_s.gsub(/s$/, "")
    rates = Numeric.class_variable_get(:@@currencies)
    value_dollar = @value * rates[@currency]
    value_dollar / rates[singular_target]

  end
end
```
- Monkey Patching: Extensão da classe Numeric com method_missing e in.
- Classes: Currency com attr_reader e métodos de conversão.
- Variáveis de Classe: `@@currencies` como hash para taxas de câmbio.
- Manipulação de Strings: gsub para singularizar moedas.


## 3. Implementações alternativas

Na primeira parte do exercício a implementação foi feita de forma imperativa, visando ser mais legível e mais fácil de entender, porém a forma funcional teria menos variáveis mutáveis e diminuiria o tamanho do programa. Um exemplo funcional seria na `count_words`:
```ruby
def count_words(string)
  string.downcase.scan(/\b[\w]+/).tally
end
```

Na segunda parte foi utilizado o yield, visando a diferenciação entre a lógica e a navegação, porém há outra abordagem utilizando recursão sendo mais direta. 
```ruby
def rps_tournament_winner(tournament)
  return rps_game_winner(tournament) if game?
  rps_game_winner([rps_tournament_winner(tournament[0]), rps_tournament_winner(tournament[1])])
end
```

Na terceira parte foi implementado o método sem Mixin, sendo simples e não poluindo classes nativas, já com o Mixin a sintaxe ficaria mais natural, mas haveria o monkey patching.
```ruby
module Palindrome
  def palindrome?
    self.downcase.gsub(/\W/, "") == self.downcase.gsub(/\W/, "").reverse
  end
end

class String
  include Palindrome
end
```

Na quarta parte do exercício a implementação foi feita utilizando Hash, outra alternativa seria utilizando array de pares que seria fácil de iterar e mais simples, e outra também seria utilizando struct, mas seria um overhead desnecessário. Um exemplo com o struct:
```ruby
Rule = Struct.new(:beats, :loses_to)
rules = {
  "R" => Rule.new("S", "P"),
  "S" => Rule.new("P", "R"),
  "P" => Rule.new("R", "S")
}
```

## 4. Análise do tempo

O tempo e o esforço para o estudo dirigido foram focados mais na implementação dos códigos, em geral colocar em prática os conceitos vistos em sala e aula, como a metaprogramação e o yield. A experiência foi proveitosa, os exercícios ajudaram bastante no aprendizado, mas acho que o estudo dirigido não foi de tão grande proveito.