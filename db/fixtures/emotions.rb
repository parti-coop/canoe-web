Emotion.sign.values.each do |sign|
  Emotion.seed_once(:sign) do |e|
    e.sign = sign
  end
end
