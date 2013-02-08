def from_json(response)
  response.should be_success
  ActiveSupport::JSON.decode(response.body)
end

def compare_json_list_to_table(json_list, table)
  json_list.should have(table.rows.size).items

  table.hashes.each do |table_row_hash|
    #ordering can be shaky, so need to find the right item in the json list
    pk = table.headers.first
    json_hash = json_list.detect{|jh| (jh[pk] || jh[pk.to_sym]) == table_row_hash[pk] }
    raise "JSON array did not contain a hash containing #{pk} => #{table_row_hash[pk]}.  Be sure to put your PK in the first column of the table." unless json_hash
    compare_json_hash_to_table_row_hash(json_hash, table_row_hash)
  end
end

def compare_json_hash_to_table_row_hash(json_hash, table_row_hash)
  table_row_hash.each do |key, control|
    test = json_hash[key] || json_hash[key.to_sym]
    if control == '*' # wildcard; just test that key exists, value is irrelevant or volatile
      test.to_s.should_not be_empty
    else
      test.to_s.should eql control
    end
  end
end

def visit_authenticated_endpoint(endpoint, credentials, data={}, params={})
  basic_auth(credentials[:user], credentials[:password])
  visit_endpoint(endpoint, data, params)
end