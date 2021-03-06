require "spec_helper"

describe PhqAssessmentMailer do
  fixtures :participants

  describe "reminder_email" do
    let(:mail) do
      PhqAssessmentMailer.reminder_email(participants(:participant1))
    end

    it "renders the headers" do
      expect(mail.subject).to eq("PHQ-9 Reminder")
      expect(mail.to).to eq([participants(:participant1).email])
      expect(mail.from).to eq(["stepcare@northwestern.edu"])
    end

  end
end
