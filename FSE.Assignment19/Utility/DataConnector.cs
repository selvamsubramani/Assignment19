using FSE.Assignment19.DataConnect;
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

        public void ExecuteQuery(string query)
        {
            using (var connection = new SqlConnection(connectionstring))
            {
                using (var command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }



        public CustomerDataSet ExecuteTable(string procedurename, params SqlParameter[] parameters)
        {
            CustomerDataSet ds = new CustomerDataSet();
            //DataTable table = new DataTable();
            using (var connection = new SqlConnection(connectionstring))
            {
                using (var command = new SqlCommand(procedurename, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    if (parameters != null)
                        command.Parameters.AddRange(parameters);
                    using (var adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(ds, "Customers");
                    }
                }
            }
            return ds;
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
                    table.Customers.Select(row =>
                        new Customer
                        {
                            CustomerId = row.Id,
                            CustomerName = row.Name,
                            Address = row.Address,
                            DOB = row.DOB,
                            Salary = row.Salary

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
                if (table.Customers.Any())
                {
                    var row = table.Customers.First();
                    return
                        new Customer
                        {
                            CustomerId = row.Id,
                            CustomerName = row.Name,
                            Address = row.Address,
                            DOB = row.DOB,
                            Salary = row.Salary
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
                    table.Customers.Select(row =>
                        new Customer
                        {
                            CustomerId = row.Id,
                            CustomerName = row.Name,
                            Address = row.Address,
                            DOB = row.DOB,
                            Salary = row.Salary
                        }
                        ).ToList();
            }
        }

        public void CreateTableAndAddData(DataTable table, string tablename)
        {
            tablename = $"[{tablename}_{Guid.NewGuid()}]";
            var query = $"CREATE TABLE {tablename} (" +
                string.Join(", ", table.Columns.Cast<DataColumn>().Select(x => $"{x.ColumnName} {DataType(x.DataType)}")) +
                $")";
            ExecuteQuery(query);
            foreach (DataRow row in table.Rows)
            {

                query = $"INSERT INTO {tablename} SELECT " +
                    string.Join(", ", table.Columns.Cast<DataColumn>().Select(x => $"'{row[x.ColumnName]}' [{x.ColumnName}]"));
                ExecuteQuery(query);
            }
        }

        private string DataType(Type type)
        {
            if (type == typeof(Int32))
            {
                return "INT";
            }
            if (type == typeof(string))
            {
                return "VARCHAR(MAX)";
            }
            if (type == typeof(Boolean))
            {
                return "BIT";
            }
            return "VARCHAR(MAX)";
        }
    }
}