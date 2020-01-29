class ElasticSearchWorker

  include Sidekiq::Worker
  sidekiq_options queue: :elastic_search, retry: false, backtrace: true
  
  def perform(clazz, id)
    Rails.logger.debug("Indexing #{clazz} id #{id}")
    clazz.constantize.find(id).__elasticsearch__.index_document
  end
  
end