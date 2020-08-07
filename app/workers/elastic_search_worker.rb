require 'sidekiq'

class ElasticSearchWorker

  include Sidekiq::Worker
  sidekiq_options queue: :elasticsearch, retry: false, backtrace: true

  def perform(klass, id, action)
    case action
      when 'create'
        klass.constantize.find(id).__elasticsearch__.index_document
      when 'update'
        klass.constantize.find(id).__elasticsearch__.update_document
      when 'destroy'
        klazz = klass.constantize
        klazz.__elasticsearch__.client.delete index: klazz.index_name, type: klazz.document_type, id: id
    end
  end
end
