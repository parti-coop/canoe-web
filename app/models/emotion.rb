class Emotion < ApplicationRecord
  extend Enumerize
  enumerize :sign, in: %i(joy suprise digust fear angry sad hope disappoint tender disapproval remorse sorry learn insight determine try)

  PATTERN = /\B:([ㄱ-ㅎ가-힣a-z0-9_]+):/
  COLON_PATTERN = /\B(:[ㄱ-ㅎ가-힣a-z0-9_]+:)/

  def self.scan(body)
    sign_texts = parse_sign_texts(body)
    sign_texts.map do |text|
      self.find_by_sign_text text
    end.compact
  end

  def self.process(body)
    return body unless block_given?
    body.gsub(Emotion::COLON_PATTERN) do |m|
      colon_sign_text = $1
      sign_text = colon_sign_text[1..-2]
      emotion = self.find_by_sign_text sign_text
      if emotion.present?
        m.gsub($1, yield($1, emotion))
      else
        m
      end
    end
  end

  private

  def self.find_by_sign_text(text)
    value = self.sign.values.select{ |v| v.text == text }.first.try(:to_s)
    self.find_by sign: value
  end

  def self.parse_sign_texts(body)
    body.scan(Emotion::PATTERN).flatten.compact.uniq.select { |sign| self.sign.values.map(&:text).include? sign }
  end
end
