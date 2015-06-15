require_relative '../spec_helper'


describe Card do
  it "has a question" do
    card = Card.new(question: "question 1", answer: "answer 1")
    expect(card.question).to eq("question 1")
  end
end