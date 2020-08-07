# frozen_string_literal: true

#
# Adds support for calling a sidekiq job to index the model
# that includes this module.
#
module Indexable
  extend ActiveSupport::Concern
  included do
    def index_elasticsearch(action)
      ElasticSearchWorker.perform_async(self.class.name, self.id, action)
    end
  end
end
