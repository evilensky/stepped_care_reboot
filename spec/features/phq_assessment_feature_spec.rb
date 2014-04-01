require "spec_helper"

describe "PHQ assessment" do
  describe "when a participant accesses a valid link" do
    fixtures :participants

    let(:token) do
      participants(:participant1).participant_tokens
        .create!(token_type: "phq9", release_date: Date.today)
        .token
    end

    it "should allow her to submit an assessment" do
      visit "/participants/phq_assessments/new?phq_assessment[token]=#{ token }"

      expect(page).to have_text("PHQ-9")

      click_on("submit")

      expect(page).to have_text("Thank you")
    end
  end
end
