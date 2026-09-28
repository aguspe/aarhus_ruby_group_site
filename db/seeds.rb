# Create admin member
admin = Member.find_or_create_by!(email: "augustin.gbpe@gmail.com") do |m|
  m.name = "Augustin Gottlieb"
  m.admin = true
end

puts "Admin member created: #{admin.email}"

# Seed existing events
Event.find_or_create_by!(slug: "kick-off-start-of-the-year-edition") do |e|
  e.title = "Kick-Off: Start of the Year Edition"
  e.description = "Our first meetup of 2026! Come meet fellow Ruby enthusiasts in Aarhus and kick off the new year together."
  e.location = "LYNfabrikken"
  e.address = "Vestergade 49B, 8000 Aarhus"
  e.starts_at = DateTime.new(2026, 2, 28, 13, 30, 0)
  e.published = true
end

Event.find_or_create_by!(slug: "ruby-and-ai-what-is-the-role-of-ruby-in-the-new-ai-world") do |e|
  e.title = "Ruby and AI: What is the role of Ruby in the new AI world?"
  e.description = "Explore how Ruby fits into the rapidly evolving AI landscape. We'll discuss Ruby-based AI tools, integrations with AI APIs, and the future of Ruby in an AI-first world."
  e.location = "Merkle Cantine"
  e.address = "Åboulevarden 18, 8000 Aarhus"
  e.starts_at = DateTime.new(2026, 3, 31, 17, 0, 0)
  e.published = true
end

Event.find_or_create_by!(slug: "making-desktop-apps-with-rails") do |e|
  e.title = "Making Desktop Apps with Rails"
  e.description = "Learn how to build desktop applications with Rails."
  e.location = "Dentsu Cantine"
  e.address = "Åboulevarden 18, 8000 Aarhus"
  e.starts_at = DateTime.new(2026, 10, 27, 17, 0, 0)
  e.published = true
end

puts "Seeded #{Event.count} events."
