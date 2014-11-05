require_relative '../lib/email_validator'

require 'rspec/expectations'

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
  it "validates correct emails as OK" do
    expect(subject).to validate(["blablub@foo.de"])
  end
  it "validates incorrect emails as NOT OK" do
    expect(subject).not_to validate(["blablub@foo"])
  end
end
