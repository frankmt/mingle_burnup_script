class MingleApi
  include HTTParty
  
  SERVER = "test.com"
  USER = "frankmt"
  PASS = "trind82"
  
  def self.current_sprint(project_name)
    sprint_card = get("http://#{SERVER}/projects/#{project_name}/cards.xml?filters[]=[Type][is][sprint]&filters[]=[Sprint+End+Date][is+greater+than][(today)]&filters[]=[Sprint+Start+Date][is+less+than][(today)]")
    input = Nokogiri::XML(sprint_card)
    sprint_name = input.root.xpath("/cards/card/name/text()").to_s
    
    sprint_name.empty? ? nil : sprint_name
  end
  
end