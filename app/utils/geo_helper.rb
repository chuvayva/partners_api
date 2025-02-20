module GeoHelper
  class << self
    def operating_area(address, operating_radius)
      sql = ActiveRecord::Base.sanitize_sql([ <<-SQL.squish, address.location.x, address.location.y, operating_radius ])
        SELECT ST_Buffer(ST_MakePoint(?, ?)::geography, ?);
      SQL

      ActiveRecord::Base.connection.select_value(sql)
    end
  end
end
