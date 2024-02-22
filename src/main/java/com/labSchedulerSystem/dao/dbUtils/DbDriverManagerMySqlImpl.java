package com.labSchedulerSystem.dao.dbUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbDriverManagerMySqlImpl implements DbDriverManager {	
	

		public Connection getConnection() throws ClassNotFoundException, SQLException {	

			Class.forName("com.mysql.jdbc.Driver");
			
			String url = "jdbc:mysql://127.0.0.1:3306/cis6003_lab_app";
			String userName = "root";
			String password = "Isira0615#";
			
			return DriverManager.getConnection(url, userName, password);
		}

	}


