module ApplicationHelper
  def date_f(date)
    timeago_tag date, lang: :ko, limit: 3.days.ago
  end

  def byline(user, options={})
    return if user.nil?
    raw render(partial: 'users/byline', locals: options.merge(user: user))
  end

  def markdown(body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, no_intra_emphasis: true,
      tables: true, disable_indented_code_blocks: true,
      fenced_code_blocks: true, autolink: true,
      strikethrough: true, hard_wrap: true, space_after_headers: true)

    raw(markdown.render(body))
  end

  def smart_format(text, html_options = {}, options = {})
    parsed_text = simple_format(h(text), html_options, options).to_str
    parsed_text = Emotion.process(parsed_text) do |matched, emotion|
      content_tag(:span, emotion.sign_text, class: "emotion emotion-#{emotion.sign}")
    end
    parsed_text = auto_link(parsed_text,
      html: {class: 'auto_link', target: '_blank'},
      link: :urls,
      sanitize: false)
    raw(parsed_text)
  end
end
