using EmployeeManagement.Model.SalaryModel;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace EmployeeManagement
{
    public class Salary
        {
            private static SqlConnection ConnectionSetup()
            {
                return new SqlConnection(@"Data Source=(localdb)\ProjectsV13;Initial Catalog=payroll_services;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
            }

            public int UpdateEmployeeSalary(SalaryUpdateModel salaryUpdateModel)
            {
                SqlConnection SalaryConnection = ConnectionSetup();
                int salary = 0;
                try
                {
                    using (SalaryConnection)
                    {
                        string id = Console.ReadLine();
                        string query = @"select * from Employee where id=" + Convert.ToInt32(id);
                        SalaryDetailModel displayModel = new SalaryDetailModel();
                        SqlCommand command = new SqlCommand("spUpdateEmployeeSalary", SalaryConnection);
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@id", salaryUpdateModel.SalaryId);
                        command.Parameters.AddWithValue("@month", salaryUpdateModel.Month);
                        command.Parameters.AddWithValue("@salary", salaryUpdateModel.EmployeeSalary);
                        command.Parameters.AddWithValue("@EmpId", salaryUpdateModel.EmployeeId);
                        SalaryConnection.Open();
                        SqlDataReader dr = command.ExecuteReader();
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                displayModel.EmployeeId = Convert.ToInt32(dr["EmpId"]);
                                displayModel.EmployeeName = dr["ENAME"].ToString();
                                displayModel.JobDescription = dr["jOB"].ToString();
                                displayModel.EmployeeSalary = Convert.ToInt32(dr["EMPSAL"]);
                                displayModel.Month = dr["SAL_MONTH"].ToString();
                                displayModel.SalaryId = Convert.ToInt32(dr["SALARYId"]);
                                Console.WriteLine(displayModel.EmployeeName + " " + displayModel.EmployeeSalary + " " + displayModel.Month);
                                Console.WriteLine("\n");
                                salary = displayModel.EmployeeSalary;
                            }
                        }
                        else
                        {
                            Console.WriteLine("No data found.");
                        }

                    }
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                finally
                {
                    SalaryConnection.Close();
                }
                return salary;
            }
    }


}

