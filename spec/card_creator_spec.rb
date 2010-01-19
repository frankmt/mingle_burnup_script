require File.dirname(__FILE__) + '/spec_helper'

describe CardCreator do
  
  describe "create_daily_card" do

    it "should create aggregated card" do
      fail
      card_creator = DailyCardCreator.new
      
      MingleApi.stub!(:current_sprint).and_return("112")
      MingleApi.stub!(:sprint_cards).and_return(aggregated_cards)
      
      MingleApi.should_receive(:create_card).with(:date => blah, :original => 6, :remaining => 4, :number_of_cards => 2)
      card_creator.create_card
    end
    
    it "should overwrite the card if it already exists" do
      fail
    end
    
    it "should not create a card if no card for current sprint is found" do
      fail
    end
    
  end
  
  def aggregated_cards
    <<-XML
    <cards type="array">
      <card>
        <card_type_name>SubTask</card_type_name>
        <original_estimate>2</original_estimate>
        <remaining_estimate>1</remaining_estimate>
        <id>113</id>
      </card>
      <card>
        <card_type_name>SubTask</card_type_name>
        <original_estimate>4</original_estimate>
        <remaining_estimate>3</remaining_estimate>
        <id>114</id>
      </card>
    </cards>
    XML
  end
  
end