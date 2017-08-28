# frozen_string_literal: true
require 'github/github_service'

module Github
  class CreateIssueJob
    include Sidekiq::Worker

    # limit the rate at which Github API calls are made
    # so as not to trigger Github spam protections
    sidekiq_options queue: 'low',
                    rate: {
                      name: 'prevent_feedback_spam',
                      limit: 20,
                      period: 3600, ## An hour
                    }

    # :nocov:
    def perform(feedback)
      Github::GithubService.create_issue(feedback)
    end
    # :nocov:
  end
end