#Below are all the tests I used while making the program.
module Tests
  def test_create
    test_create = VoterSim.new
    test_create.create_politician
    test_create.create_person
    test_create.create_voter
    p test_create
  end

  def test_list
    test = VoterSim.new
    test_politician = test.create_politician("matt" , "democrat")
    test_person = test.create_person("ashley", "liberal")   
    puts test.all_voters
    puts test.list_voters
  end

  def test_update
  test = VoterSim.new
  test_politician = test.create_politician("matt" , "democrat")
  test_person = test.create_person("ashley", "liberal")
  p test.all_voters
  selected_voter = test.ask_update_voters(2)
  p selected_voter
  end  

  def test_campaign
    test = VoterSim.new
    test_politician_1 = test.create_politician("hilary", "democrat")
    test_politician_2 = test.create_politician("bill", "democrat")
    test_politician_3 = test.create_politician("bush", "republican")
    test_person_1 = test.create_person("ashley", "liberal")
    test_person_2 = test.create_person("juha", "tea party")
    test_person_3 = test.create_person("damon", "conservative")
    test_person_4 = test.create_person("sam", "neutral")
    test_person_5 = test.create_person("anuvis", "socialist")

    test.campaign_start
    p test.all_voters
  end  

  def test_tally
    test = VoterSim.new
    test_politician_1 = test.create_politician("hilary", "democrat")
    test_politician_2 = test.create_politician("bill", "democrat")
    test_politician_3 = test.create_politician("bush", "republican")
    test_person_1 = test.create_person("ashley", "liberal")
    test_person_2 = test.create_person("juha", "tea party")
    test_person_3 = test.create_person("damon", "conservative")
    test_person_4 = test.create_person("sam", "neutral")
    test_person_5 = test.create_person("anuvis", "socialist")

    test.campaign_start
    test.tally_vote
    p test.all_voters
  end
end