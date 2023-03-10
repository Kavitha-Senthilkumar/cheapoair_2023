# frozen_string_literal: true

module UtilitiesModules
  def verify_both_value_are_same? exp_val , act_val
    fail "Expected -#{exp_val} is not same as Actual value -#{act_val} " unless exp_val == act_val
  end
  def verify_expected_value_exits? act_val , exp_val
    fail "Expected value -#{exp_val} does not exist in Actual Value - #{act_val}" unless act_val.include? exp_val
  end
end
