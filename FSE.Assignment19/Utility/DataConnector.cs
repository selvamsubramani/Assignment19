using FSE.Assignment19.Dto;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace FSE.Assignment19.Utility
{
    public class DataConnector
    {
        private string connectionstring;
        private DataConnector()
        {
            connectionstring = ConfigurationManager.ConnectionStrings["Assignment19"].ConnectionString;
        }
        private static readonly Lazy<DataConnector> lazy = new Lazy<DataConnector>(() => new DataConnector());
        public static DataConnector Instance
        {
            get
            {
                return lazy.Value;
            }
        }
        public DataTable ExecuteTable(string procedurename, params SqlParameter[] parameters)
        {
            DataTable table = new DataTable();
            using (var connection = new SqlConnection(connectionstring))
            {
                using (var command = new SqlCommand(procedurename, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    if (parameters != null)
                        command.Parameters.AddRange(parameters);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(table);
                    }
                }
            }
            return table;
        }
        public void ExecuteReader(string procedurename, params SqlParameter[] parameters)
        {
            DataTable table = new DataTable();
            using (var connection = new SqlConnection(connectionstring))
            {
                using (var command = new SqlCommand(procedurename, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    if (parameters != null)
                        command.Parameters.AddRange(parameters);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
        public List<Customer> GetCustomers()
        {
            using (var table = ExecuteTable("GetCustomers"))
            {
                return
                    table.AsEnumerable().Select(row =>
                        new Customer
                        {
                            CustomerId = row.Field<int>("Id"),
                            CustomerName = row.Field<string>("Name"),
                            Address = row.Field<string>("Address"),
                            DOB = row.Field<DateTime>("DOB"),
                            Salary = row.Field<int>("Salary")

                        }).ToList();
            }
        }
        public void AddCustomer(Customer customer)
        {
            var parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Name", customer.CustomerName));
            parameters.Add(new SqlParameter("DOB", customer.DOB));
            parameters.Add(new SqlParameter("Address", customer.Address));
            parameters.Add(new SqlParameter("Salary", customer.Salary));
            ExecuteReader("AddCustomer", parameters.ToArray());
        }
        public Customer GetCustomerById(int id)
        {
            var parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Id", id));
            using (var table = ExecuteTable("GetCustomerById", parameters.ToArray()))
            {
                if (table.AsEnumerable().Any())
                {
                    var row = table.AsEnumerable().First();
                    return
                        new Customer
                        {
                            CustomerId = row.Field<int>("Id"),
                            CustomerName = row.Field<string>("Name"),
                            Address = row.Field<string>("Address"),
                            DOB = row.Field<DateTime>("DOB"),
                            Salary = row.Field<int>("Salary")

                        };
                }
                return null;
            }
        }
        public void DeleteCustomer(int id)
        {
            var parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Id", id));
            ExecuteReader("DeleteCustomer", parameters.ToArray());
        }
        public void UpdateCustomer(Customer customer)
        {
            var parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Id", customer.CustomerId));
            parameters.Add(new SqlParameter("Name", customer.CustomerName));
            parameters.Add(new SqlParameter("DOB", customer.DOB));
            parameters.Add(new SqlParameter("Address", customer.Address));
            parameters.Add(new SqlParameter("Salary", customer.Salary));
            ExecuteReader("UpdateCustomer", parameters.ToArray());
        }

        public List<Customer> GetCustomerBornAfterDate(DateTime date)
        {
            var parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Date", date));
            using (var table = ExecuteTable("GetCustomerBornAfterDate", parameters.ToArray()))
            {
                return
                    table.AsEnumerable().Select(row =>
                        new Customer
                        {
                            CustomerId = row.Field<int>("Id"),
                            CustomerName = row.Field<string>("Name"),
                            Address = row.Field<string>("Address"),
                            DOB = row.Field<DateTime>("DOB"),
                            Salary = row.Field<int>("Salary")

                        }).ToList();
            }
        }
    }
}