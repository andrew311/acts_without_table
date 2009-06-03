# ActsWithoutTable
module ActsWithoutTable
  
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    def columns
      self.acts_without_table_columns.collect do |name, type|
        ActiveRecord::ConnectionAdapters::Column.new(name.to_s, nil, type.to_s, false)
      end
    end
  end
  
end

class ActiveRecord::Base
  
  def self.acts_without_table(columns = {})
    self.class_inheritable_accessor :acts_without_table_columns
    self.acts_without_table_columns = columns
    include ActsWithoutTable
  end
  
end