require_relative '../lib/email_validator'

require 'rspec/expectations'
require 'rantly/property'

RSpec::Matchers.define :validate do |to_validate|
  match do |validator|
    validator.validate(to_validate)
  end
  failure_message_for_should do |validator|
    "expected that #{validator} would validate #{to_validate} as correct"
  end
  failure_message_for_should_not do |validator|
    "expected that #{validator} would not validate #{to_validate} as correct"
  end
end

describe EmailValidator do
  def valid_email(r)
    r.string(:alpha) + r.string(:alnum) + "@" + r.string(:alpha) + "." + r.sized(3) {r.string(:alpha)}
  end
  def invalid_email(r)
    r.branch(
      lambda {|r| r.string(:alpha) + r.string(:alnum) + r.string(:alpha) + r.sized(3) {r.string(:alpha)} },
      lambda {|r| r.string(:alpha) + r.string(:alnum) + r.string(:alpha) + "." + r.sized(3) {r.string(:alpha)} },
      lambda {|r| r.string(:alpha) + r.string(:alnum) + "@" + r.string(:alpha) + r.sized(3) {r.string(:alpha)} }
    )
  end
  def valid_emails(r)
    r.array &method(:valid_email)
  end
  def invalid_emails(r)
    (r.array(&method(:valid_email)) + r.array(1, &method(:invalid_email))).shuffle
  end
  it "validates correct emails as OK" do
    property_of(&method(:valid_emails)).check {|em| expect(subject).to validate(em) }
  end
  it "validates incorrect emails as NOT OK" do
    property_of(&method(:invalid_emails)).check {|em| expect(subject).not_to validate(em) }
  end
end
