require 'cgi'
require 'rest_client'
require 'happymapper'
require 'nokogiri'
require 'virtus'
require 'hashie'

module PivotalTracker

  autoload :Activity, "pivotal-tracker/activity"
  autoload :Attachment, "pivotal-tracker/attachment"
  autoload :Change, "pivotal-tracker/change"
  autoload :Client, "pivotal-tracker/client"
  autoload :Epic, "pivotal-tracker/epic"
  autoload :Extensions, "pivotal-tracker/extensions"
  autoload :Iteration, "pivotal-tracker/iteration"
  autoload :Label, "pivotal-tracker/label"
  autoload :Me, "pivotal-tracker/me"
  autoload :Membership, "pivotal-tracker/membership"
  autoload :Note, "pivotal-tracker/note"
  autoload :PrimaryResource, "pivotal-tracker/primary_resource"
  autoload :Project, "pivotal-tracker/project"
  autoload :Proxy, "pivotal-tracker/proxy"
  autoload :Story, "pivotal-tracker/story"
  autoload :Task, "pivotal-tracker/task"
  autoload :Validation, "pivotal-tracker/validation"
  autoload :Virtusable, "pivotal-tracker/virtusable"

  module Coercion
    autoload :Hashie, "pivotal-tracker/coercion/hashie"
  end

  # define error types
  class ProjectNotSpecified < StandardError; end

  def self.encode_options(options)
    options_strings = options.inject({}) do |m, (k,v)|
      if [:limit, :offset].include?(k.to_sym)
        m.update k => v
      elsif k.to_sym == :search
        m.update :filter => v
      else
        filter_query = %{#{k}:#{[v].flatten.join(",")}}
        m.update :filter => (m[:filter] ? "#{m[:filter]} #{filter_query}" : filter_query)
      end
    end.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}"}

    %{?#{options_strings.join("&")}} unless options_strings.empty?
  end

end
