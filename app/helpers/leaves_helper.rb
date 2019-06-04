module LeavesHelper
  def count_leaves
    current_employee.leaves.count
  end
end
