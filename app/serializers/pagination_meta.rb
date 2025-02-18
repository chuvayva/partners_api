class PaginationMeta
  def self.call(collection)
    {
      pagination: {
        current_page: collection.current_page,
        per_page: collection.limit_value,
        total_pages: collection.total_pages,
        total_records: collection.total_count
      }
    }
  end
end
