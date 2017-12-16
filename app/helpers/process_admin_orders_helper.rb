module ProcessAdminOrdersHelper
   def included_in? array
    array.to_set.superset?(self.to_set)
  end
end
