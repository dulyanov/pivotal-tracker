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
end

