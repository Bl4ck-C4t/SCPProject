class ApplicationController < ActionController::Base
	def pagination(table, count_parameter)
	    if(params["limit"])
	      @limit = params["limit"].to_i
	    else
	      @limit = 2
	    end

	    pages_query = "SELECT COUNT(%s) as count
	                   FROM %s" % [count_parameter, table]
	    facility_count = ActiveRecord::Base.connection.execute(pages_query)
	    @total_pages = (facility_count[0]["count"].to_f / @limit).ceil

	    if(params["page"])
	      @page = [params["page"].to_i, @total_pages-1].min
	    else
	      @page = 0
	    end
	    
	    query = "SELECT * FROM %s LIMIT ? OFFSET ?" % [table]
	    # query2 = "SELECT * FROM facilities"
	    # @facilities2 = Facility.find_by_sql(query2)
	    vals = [[nil, @limit], [nil, @page*@limit]]
	    return ActiveRecord::Base.connection.exec_query(query, "all facilities", vals)
	end
end
