class EmailValidator
  REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  def validate(emails)
    emails.all? {|em| REGEX =~ em }
  end
end
