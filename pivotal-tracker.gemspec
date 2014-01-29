Gem::Specification.new do |s|
  s.name = "pivotal-tracker"
  s.version = "0.5.12"
  s.authors = ["Justin Smestad", "Josh Nichols", "Terence Lee"]
  s.date = "2013-09-04"
  s.email = "justin.smestad@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split($/)
  s.homepage = "http://github.com/jsmestad/pivotal-tracker"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.7"
  s.summary = "Ruby wrapper for the Pivotal Tracker API"

  s.add_dependency "rest-client"
  s.add_dependency "hashie"
  s.add_dependency "json"
  s.add_dependency "nokogiri-happymapper"
  s.add_dependency "nokogiri"
  s.add_dependency "virtus"
  s.add_dependency "builder"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
end

