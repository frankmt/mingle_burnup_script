require File.dirname(__FILE__) + '/spec_helper'

describe MingleApi do
  
  describe "current sprint" do
    
    before :all do
      @project_name = "sporting_bet_macro"
      @expected_url = "http://#{MingleApi::SERVER}/projects/#{@project_name}/cards.xml" +
      "?filters[]=[Type][is][sprint]" +
      "&filters[]=[Sprint+End+Date][is+greater+than][(today)]" +
      "&filters[]=[Sprint+Start+Date][is+less+than][(today)]"
    end
    
    it "should retrieve current sprint number based on today's date" do
      FakeWeb.register_uri(:get, "#{@expected_url}", :body => card_sprint)  
      MingleApi.current_sprint(@project_name).should == "Sprint 3"
    end
    
    it "should return null if we dont have a current sprint" do
      FakeWeb.register_uri(:get, "#{@expected_url}", :body => empty_card_set)  
      MingleApi.current_sprint(@project_name).should be_nil
    end
    
  end
  
  def card_sprint
    <<-XML
    <cards type="array">
      <card>
        <card_type_name>Sprint</card_type_name>
        <name>Sprint 3</name>
      <card>
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


