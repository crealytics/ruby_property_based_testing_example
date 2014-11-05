class EmailValidator
  REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  def validate(emails)
    REGEX =~ emails.first
  end
end
