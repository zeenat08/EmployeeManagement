using System;
using System.Collections.Generic;
using System.Text;

namespace EmployeeManagement.Model.SalaryModel
{
        public class SalaryUpdateModel
        {
            public int salaryId;

            public int SalaryId { get; set; }
            public string Month { get; set; }
            public int EmployeeSalary { get; set; }
            public int EmployeeId { get; set; }
        }
}

