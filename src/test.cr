require "liquid"

txt = "<title>{% if page.title %}{{ page.title }}{% else %}{{ site.title }}{% endif %}</title>"
ctx = Liquid::Context.new
ctx.set "site", {"title"=>"Site Title"}
tpl = Liquid::Template.parse txt
result = tpl.render ctx
puts result