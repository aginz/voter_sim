module CommonActions
  def ask(message, variable = nil)
    puts message
    if variable == nil
      input = gets.chomp.strip.downcase
    else
      return variable
    end
  end

  def invalid_entry
    puts "Invalid entry."
  end
end

class VoterSim
  include CommonActions
  attr_accessor :politician_array, :person_array

  def initialize
    @politician_array = []
    @person_array = []
  end

  def all_voters
    voters = @politician_array + @person_array
    voters
  end

  def start
    until @winner
      main_menu
    end
  end

  def main_menu (select_menu = nil)
  select_menu = ask ("What would you like to do? Create, List, Update or Vote.")
    case select_menu
    when "create"
      create_voter
    when "list"
      list_voters unless all_voters.size == 0
    when "update"
      update_voter_info unless all_voters.size == 0
    when "vote"
      campaign_start unless @politician_array.size == 0
      tally_vote unless @politician_array.size == 0
      @winner = true unless @politician_array.size == 0
      puts "You need to create a politician first." unless @politician_array.size > 0
    else
      invalid_entry
      main_menu
    end
    start
  end
  
  def create_voter
    new_voter = ask("What would you like to create? Politician or Person.")
    case new_voter
    when "politician"
      create_politician
    when "person"
      create_person
    else
      invalid_entry
      create_voter
    end
  end

  def ask_name(name = nil)
    name = ask("What is your name?", name)
    while name.match(/\d/)
      name = ask("That's not a valid name. What is your name?", name)
    end
    name
  end

  def ask_party(party = nil)
    party = ask("What is your party? Republican or Democrat.", party)
    until party == "republican" || party == "democrat" 
      party = nil
      party = ask("That's not a valid party. Choose Republican or Democrat.", party)
    end
    party
  end

  def ask_politics(politics = nil)
    politics = ask("What is your political view? Liberal, Conservative, Tea Party, Socialist, or Neutral.", politics)
    until politics == "liberal" || politics == "conservative" || politics == "tea party" || politics == "socialist" || politics == "neutral"
      politics = nil
      politics = ask("That is not a valid response. Choose Liberal, Conservative, Tea Party, Socialist or Neutral.", politics)
    end
    politics
  end

  def create_politician(name = nil, party = nil)
    name = ask_name(name)
    party = ask_party(party)
    @politician_array << Politician.new(name, party)
  end

  def create_person(name = nil, politics = nil)
    name = ask_name(name)
    politics = ask_politics(politics)
    @person_array << Person.new(name, politics)
  end

  def list_voters
    all_voters.each do |voter|
      if voter.type_of_voter == "politician" 
        puts "Politician, #{voter.name}, #{voter.party}, Voter ID: #{voter.id}".upcase
      else
        puts "Voter, #{voter.name}, #{voter.politics}, Voter ID: #{voter.id}".upcase
      end
    end 
  end

  def ask_update_voters(selected_voter_id = nil)
    selected_voter_id = ask("What is the voter ID of the voter you would like to update? To see a list of voter IDs, type list.", selected_voter_id)
    
    if selected_voter_id == "list"
      list_voters
      selected_voter_id = nil
      ask_update_voters
    elsif selected_voter_id.to_i <= 0 #returns error if id selected is string or less than 0.
      invalid_entry
      selected_voter_id = nil
      ask_update_voters 
    elsif selected_voter_id.to_i > all_voters.size #returns error if voter ID selected is greater than the last voter ID.
      invalid_entry
      selected_voter_id = nil
      ask_update_voters
    else
      selected_voter_id #returns valid voter ID.
    end
    
    if all_voters.size > 1
      sorted_voters = all_voters.sort_by { |voter| voter.id } 
      index = selected_voter_id.to_i - 1
      return sorted_voters[index] #returns selected voter based on ID.
    else
      return all_voters[0] #returns selected voter if only one voter created.
    end   
  end

  def update_voter_info(selected_info = nil)
    @selected_voter = ask_update_voters(selected_voter_id = nil) #executing the ask_update_voters method will return the selected voter object based on voter ID.
    selected_info = ask("What would you like to update? Name or Politics?", selected_info) if @selected_voter.type_of_voter == "person" 
    selected_info = ask("What would you like to update? Name or Party?", selected_info) if @selected_voter.type_of_voter == "politician"
    case selected_info
    when "name"
      update_name(name = nil)
    when "party"
      update_party(party = nil)
    when "politics"
      update_politics(politics = nil)
    else
      invalid_entry
      update_voter_info(selected_info = nil)
    end
  end

  def update_name(name = nil)
    name = ask_name(name)
    @selected_voter.name = name
    puts "Updated name to #{@selected_voter.name}."
  end
    
  def update_party(party = nil)
    party = ask_party(party)
    @selected_voter.party = party
    puts "Updated party to #{@selected_voter.party}"
  end

  def update_politics(politics = nil)
    politics = ask_politics(politics)
    @selected_voter.politics = politics
    puts "Updated party to #{@selected_voter.politics}"
  end

  def campaign_start
    counter = 0
    while counter < all_voters.size
      @voter_current = all_voters[counter]
      politician_array.each {|p| p.vote = p.id} #sets politician vote to own ID
      politician_array.each do |politician| 
        next if politician.id == @voter_current.id #skips politician so they don't talk to themselves as a voter.
        @politician_current = politician
        stump_speech
      end
      if @voter_current.vote == false #voter will speak to all politicians until voter decides on a candidate.
        counter
      else
        counter += 1
      end
    end
  end

  def voter_response(chance)
  vote = (rand <= chance / 100.0) #returns true or false based on chance
    if vote == true
      puts "Voter #{@voter_current.name.upcase}: Sure, I'll vote for you."
      @voter_current.vote = @politician_current.id #sets vote to politician ID.
    else
      puts "Voter #{@voter_current.name.upcase}: Sorry, I'm voting for someone else."
    end
  end

  def stump_speech
    puts "Politician #{@politician_current.name.upcase}: I think you should vote for me."
    if @voter_current.type_of_voter == "politician" 
      puts "Voter #{@voter_current.name.upcase}: I would never vote for an idiot!"
    else
      voter_politics = @voter_current.politics
      voter_politics
      case voter_politics
      when "tea party"
        voter_response(90) if @politician_current.party == "republican"
        voter_response(10) if @politician_current.party == "democrat"
      when "conservative"
        voter_response(75) if @politician_current.party == "republican"
        voter_response(25) if @politician_current.party == "democrat"
      when "neutral"
        voter_response(50) if @politician_current.party == "republican"
        voter_response(50) if @politician_current.party == "democrat"
      when "liberal"
        voter_response(25) if @politician_current.party == "republican"
        voter_response(75) if @politician_current.party == "democrat"
      when "socialist"
        voter_response(10) if @politician_current.party == "republican"
        voter_response(90) if @politician_current.party == "democrat"
      end
    end
  end

  def tally_vote
    all_voters.each do |voter|
      politician_array.each do |politician|
        if voter.vote == politician.id
          politician.number_of_votes += 1 #counts all votes based on politician ID
        end
      end
    end
    sorted_politicians = politician_array.sort_by {|p| p.number_of_votes} #sorts politicians based on number of votes
    puts "#{sorted_politicians.last.name.upcase} WINS THE ELECTION!"
  end
end

class Voter 
  attr_accessor :name, :id, :vote

  @@serial = 1

  def initialize(name)
    @vote = false
    @name = name
    @id = @@serial
    @@serial += 1 
  end
end

class Politician < Voter
  attr_accessor :party, :type_of_voter, :number_of_votes

  def initialize(name, party)
    @number_of_votes = 0
    @party = party
    super(name)
    @type_of_voter = "politician"
  end
end

class Person < Voter
  attr_accessor :politics, :type_of_voter

  def initialize(name, politics)
    @politics = politics
    super(name)
    @type_of_voter = "person"
  end
end

test = VoterSim.new
test.start

