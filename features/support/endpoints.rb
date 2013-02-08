def visit_endpoint(endpoint, data={}, params={})
  params[:format] ||= 'json'
   args = case endpoint
           when /^get$/i
      visit reg_server_path(params), :get
           when /^post$/i
      visit reg_server_path(params), :post, {:data => $1}
           else raise "no action to take for '#{endpoint}'"
         end
  @response
  end