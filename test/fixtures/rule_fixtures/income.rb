##### GENERATED AT 2015-07-06 17:08:30 -0400 ######
class IncomeFixture < MagiFixture
  attr_accessor :magi, :test_sets

  def initialize
    super
    @magi = 'Income'
    @test_sets = [
      # ensure that medicaid threshold is making its way down properly 
      {
        test_name: "Income - Set Percentage Used",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "N",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 0,
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 10,
          "FPL Per Person" => 10,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "N",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Percentage for Medicaid Category Used" => {"percentage" => "Y", "method" => "standard", "threshold" => 100},
          "Percentage for CHIP Category Used" => {"percentage" => "Y", "method" => "standard", "threshold" => 133},
        }
      },
      {
        test_name: "Income - Set FPL Percentage",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "Y",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 0,
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "N",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "FPL" => 20090,
          "FPL * Percentage Medicaid" => 21094.5, # not sure how the math for this works out
          "FPL * Percentage CHIP" => 27724.2, # not sure how the math for this works out either 
          "Category Used to Calculate Medicaid Income" => 'Adult Group Category',
          "Category Used to Calculate CHIP Income" => 'Pregnancy Category'
        }
      },

      # determine income eligibility rule - Medicaid
      {
        test_name: "Determine Medicaid Income Eligibility - Max Eligible Medicaid None",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "N",
          "Applicant Pregnancy Category Indicator" => "N",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 0,
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "N",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Applicant Income Medicaid Eligible Indicator" => "N",
          "Income Medicaid Eligible Ineligibility Reason" => 401
        }
      },
      {
        test_name: "Determine Medicaid Income Eligibility - Calculated Income Greater Than Max Eligible",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "N",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 22090, # slightly higher than fpl * percentage medicaid from above
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "N",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Applicant Income Medicaid Eligible Indicator" => "N",
          "Income Medicaid Eligible Ineligibility Reason" => 402
        }
      },
      {
        test_name: "Determine Medicaid Income Eligibility - Calculated Income Lower Than Max Eligible",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "N",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 20000, 
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "N",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Applicant Income Medicaid Eligible Indicator" => "Y",
          "Income Medicaid Eligible Ineligibility Reason" => 999
        }
      },

      # determine income eligibility rule - CHIP - 27724.2
      {
        test_name: "Determine CHIP Income Eligibility - No CHIP Eligibility",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "N",
          "Applicant Pregnancy Category Indicator" => "N",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 20000, 
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "Y",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Applicant Income CHIP Eligible Indicator" => "N",
          "Income CHIP Eligible Ineligibility Reason" => 401
        }
      },
      {
        test_name: "Determine CHIP Income Eligibility - Calculated Income Greater than Max Eligible Income",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "Y",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 30000, 
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "Y",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Applicant Income CHIP Eligible Indicator" => "N",
          "Income CHIP Eligible Ineligibility Reason" => 402
        }
      },
      {
        test_name: "Determine CHIP Income Eligibility - Calculated Income Lower than Max Eligible Income",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "Y",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "Y",
          "Applicant CHIP Targeted Low Income Child Indicator" => "Y",
          "Calculated Income" => 20000, 
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 11770,
          "FPL Per Person" => 4160,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "Y",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
          "Applicant Income CHIP Eligible Indicator" => "Y",
          "Income CHIP Eligible Ineligibility Reason" => 999
        }
      },



      {
        test_name: "Bad Info - Inputs",
        inputs: {
          "Applicant Age" => 20
        },
        configs: {
          "Base FPL" => 10,
          "FPL Per Person" => 10,
          "FPL" => { "2015" => { "Base FPL" => 11770, "FPL Per Person" => 4160 } },
          "Option CHIP Pregnancy Category" => "N",
          "Medicaid Thresholds" => { "Adult Group Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 100 } },
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
        }
      },
      {
        test_name: "Bad Info - Configs",
        inputs: {
          "Application Year" => 2015,
          "Applicant Adult Group Category Indicator" => "Y",
          "Applicant Pregnancy Category Indicator" => "N",
          "Applicant Parent Caretaker Category Indicator" => "N",
          "Applicant Child Category Indicator" => "N",
          "Applicant Optional Targeted Low Income Child Indicator" => "N",
          "Applicant CHIP Targeted Low Income Child Indicator" => "N",
          "Calculated Income" => 0,
          "Medicaid Household" => MedicaidHousehold.new("house", '', '', '', 3),
          "Applicant Age" => 20
        },
        configs: {
          "CHIP Thresholds" => { "Pregnancy Category" => { "percentage" => "Y", "method" => "standard", "threshold" => 133 } }
        },
        expected_outputs: {
        }
      }     
    ]
  end
end

# NOTES
# This is very deeply confusing due to max eligible medicaid category. Punting. -CF 7/6/2015



# expected_outputs: {
#   "Percentage for Medicaid Category Used" => 0,
#   "Percentage for CHIP Category Used" => 0,
#   "FPL" => 0,
#   "FPL * Percentage Medicaid" => 0,
#   "FPL * Percentage CHIP" => 0,
#   "Category Used to Calculate Medicaid Income" => 0,
#   "Category Used to Calculate CHIP Income" => 0,
#   "Applicant Income Medicaid Eligible Indicator" => 0,
#   "Income Medicaid Eligible Ineligibility Reason" => 0,
#   "Applicant Income CHIP Eligible Indicator" => 0,
#   "Income CHIP Eligible Ineligibility Reason" => 0
# }


# config thresholds; 
# "Medicaid Thresholds": { "Adult Group Category": { "percentage": "Y", "method": "standard", "threshold": 100 }
#   "Parent Caretaker Category": {
#     "percentage": "Y",
#     "method": "standard",
#     "threshold": 100
#   },
#   "Pregnancy Category": {
#     "percentage": "Y",
#     "method": "standard",
#     "threshold": 100
#   },
#   "Child Category": {
#     "percentage": "Y",
#     "method": "standard",
#     "threshold": 100
#   },
#   "Optional Targeted Low Income Child": {
#     "percentage": "Y",
#     "method": "standard",
#     "threshold": 100
#   }
# },

# "CHIP Thresholds": {
# "Pregnancy Category": { "percentage": "Y", "method": "standard", "threshold": 133 },
#   "Child Category": {
#     "percentage": "Y",
#     "method": "standard",
#     "threshold": 100
#   },
#   "CHIP Targeted Low Income Child": {
#     "percentage": "Y",
#     "method": "standard",
#     "threshold": 100
#   }
# }