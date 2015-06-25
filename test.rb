def voter_response(chance)
  vote = (rand <= chance / 100.0) #returns true or false based on chance
  vote
end

p voter_response(90)

def campaign_start
    counter = 0
    while counter < all_voters.size - 1
      @voter_current = all_voters[counter]
      if @voter_current.type_of_voter == "politician"
        relevant_politicians = politician_array.reject { |p| p.id == @voter_current.id}
      end
      relevant_politicians.each do |politician| 
        @politician_current = politician
        stump_speech
      end
      counter += 1
    end
  end


# test.ask_update_voter_info("party", "tea party")
# p test.all_voters
# p test.all_voters

# p test.update_voters

# test.voters.each do |voter|
#   if voter.type_of_voter == "politician"
#     puts voter.name 
#     puts voter.party
#   end   
# end 
# p test.voters.first.type_of_voter


# test_list = List.new
# p test_list.all_voters

# class List
#   attr_accessor :all_voters
#   def initialize
#     @all_voters = create.voters #how can I access voter array from create class?
#   end

#   def list_voters
#     @all_voters.each do |voter|
#       if @all_voters.politican == true 
#         puts "Politician, #{voter.name}, #{voter.party}"
#       else
#         puts "Voter, #{voter.name}, #{voter.politics}"
#       end
#     end 
#   end
# end


  #   politician_array.each do |politician|
  #     stump_speach
  #   end

  #   all_voters.each do
  # end  


      
  #     @politician_current = politician_array.at(counter)

  #     politician_index = rand(0...politician_array.size)
  # #   @politician_current = politician_array[politician_index]
  #   @politician_current
  # end

  # def vote
  #   counter = 0
  #   while counter < all_voters.size
  #     @voter_current = all_voters[counter]
  #     if @voter_current.type_of_voter == "politician"
  #       relevant_politicians = politician_array.reject { |p| p.id == @voter_current.id}
  #     politician_array.do |politician|
  #       @politician_current = politician
  #       stump_speech
  #     end
  #     while @politician_current.id == voter_current.id
  #       random_politician
  #     end
  #     stump_speech
  #     counter ++
  #   end
  # end

  # def stump_speech
  #   puts "Politician #{@politician_current.name}: I think you should vote for me."
  #   if @voter_current.type_of_voter == "politician" 
  #     puts "#{@voter_current.name}: I would never vote for an idiot!"
  #   else
  #     voter_politics = @voter_current.politics
  #     voter_politics
  #     case voter_politics
  #     when "tea party"
  #       voter_response(90) if @politician_current.party == "republican"
  #       voter_response(10) if @politician_current.party == "democrat"
  #     when "conservative"
  #       voter_response(75) if @politician_current.party == "republican"
  #       voter_response(25) if @politician_current.party == "democrat"
  #     when "neutral"
  #       voter_response(50) if @politician_current.party == "republican"
  #       voter_response(50) if @politician_current.party == "democrat"
  #     when "liberal"
  #       voter_response(25) if @politician_current.party == "republican"
  #       voter_response(75) if @politician_current.party == "democrat"
  #     when "socialist"
  #       voter_response(10) if @politician_current.party == "republican"
  #       voter_response(90) if @politician_current.party == "democrat"
  #     end
  #   end
  # end