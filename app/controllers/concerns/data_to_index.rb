module DataToIndex
  extend ActiveSupport::Concern
  included do
    def set_data(collection, show_path, title, title_empty)
      {
        collection: collection,
        show_url: show_path,
        title: title,
        not_data: title_empty
      }
    end
  end
end
