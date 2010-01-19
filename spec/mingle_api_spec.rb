require File.dirname(__FILE__) + '/spec_helper'

describe MingleApi do
  
  before :all do
    @project_name = "sporting_bet_macro"
    @base_url = "http://#{MingleApi::SERVER}/projects/#{@project_name}/cards.xml"
  end
  
  describe "current sprint" do
    
    before :all do 
      @expected_url = "#{@base_url}" +
      "?filters[]=[Type][is][sprint]" +
      "&filters[]=[Sprint+End+Date][is+greater+than][(today)]" +
      "&filters[]=[Sprint+Start+Date][is+less+than][(today)]"
    end
    
    it "should retrieve current sprint number based on today's date" do
      FakeWeb.register_uri(:get, "#{@expected_url}", :body => card_sprint)  
      MingleApi.current_sprint(@project_name).should == "112"
    end
    
    it "should return null if we dont have a current sprint" do
      FakeWeb.register_uri(:get, "#{@expected_url}", :body => empty_card_set)  
      MingleApi.current_sprint(@project_name).should be_nil
    end
    
  end
  
  describe "current_sprint_cards" do
    
    it "should find the current sprint cards" do
      sprint_name = "112"
      @expected_url = "#{@base_url}" +
      "?filters[]=[Type][is][subtask]" + 
      "&filters[]=[Sprint][is][#{sprint_name}]"
      
      FakeWeb.register_uri(:get, "#{@expected_url}", :body => sprint_set)  
      MingleApi.sprint_cards(@project_name, sprint_name).should == sprint_set
    end
    
  end
  
  def sprint_set
    <<-XML
    <cards type="array">
      <card>
        <card_type_name>SubTask</card_type_name>
        <name>Blah</name>
        <id>112</id>
      </card>
      <card>
        <card_type_name>SubTask</card_type_name>
        <name>Boo</name>
        <id>114</id>
      </card>
    </cards>
    XML
  end
  
  def card_sprint
    <<-XML
    <cards type="array">
      <card>
        <card_type_name>Sprint</card_type_name>
        <name>Sprint 3</name>
        <number>112</number>
      </card>
    </cards>
    XML
  end
  
  def empty_card_set
    <<-XML
    <cards type="array">
    </cards>
    XML
  end
  
  
end


