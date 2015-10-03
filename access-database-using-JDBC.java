import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class Report {
	static Connection connection;
	static PreparedStatement showPatient;
	static PreparedStatement showDoctor;
	static PreparedStatement showAdmission;
	static PreparedStatement showDoctors;
	static PreparedStatement showRooms;
	static PreparedStatement updateAdmission;
	static ResultSet result;
	static ResultSet AdmissionResult;
	static ResultSet DoctorsResult;
	static ResultSet RoomsResult;
public static void main(String[] args)
{
	// check number of input arguments
	if (args.length == 2)
	{
		System.out.println(" 1- Report	Patients	Basic	Information \n 2- Report	Doctors	Basic	Information \n 3- Report	Admissions	Information \n 4- Update	Admissions	Payment	");
		return;
	}
	
	// register driver
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (ClassNotFoundException e) {
		System.out.println("Oracle JDBC Driver not found");
		e.printStackTrace();
		return;
	}
	
	String username = args[0];
	String password = args[1];
	
	// create connection
	connection = null;
	try {
		connection = DriverManager.getConnection("jdbc:oracle:thin:@oracle.wpi.edu:1521:WPI11grxx", username, password);
	} catch (SQLException e) {
		System.out.println("Connection failed. Check output console");
		e.printStackTrace();
		return;
	}
	
	try
	{
	int option = Integer.parseInt(args[2]);
	
	Scanner reader = new Scanner(System.in);
	
	if (option == 1)
	{
		// get input SSN
		System.out.println("Enter patient's SSN:");
		int inputSSN = reader.nextInt();
		reader.close();
		
		// create prepared statement and execute it
		showPatient = connection.prepareStatement("select * from Patient where SSN = ?");
		showPatient.setInt(1,inputSSN);
		result = showPatient.executeQuery();
		
		try
		{
			// get result and print result
			while (result.next())
			{
				int SSN = result.getInt("SSN");
				String first = result.getString("fName");
				String last = result.getString("lName");
				String address = result.getString("address");
				
				System.out.println("SSN: " + SSN);
				System.out.println("First name: " + first);
				System.out.println("Last name: " + last);
				System.out.println("Address :" + address);
			}
		} catch (SQLException e)
		{
			System.out.println("Patient not found. Check output console");
			e.printStackTrace();
			return;
		}
	}
	else 
	{if (option == 2)
	{
		// get input Doctor ID
		System.out.println("Enter Doctor's ID:");
		String inputID = reader.next();
		reader.close();
		
		// create prepared statement and execute it
		showDoctor = connection.prepareStatement("select * from Doctor where doctorID = ?");
		showDoctor.setString(1,inputID);
		result = showDoctor.executeQuery();
		
		try
		{
			while (result.next())
			{
				String doctorID = result.getString("doctorID");
				String first = result.getString("fName");
				String last = result.getString("lName");
				String gender = result.getString("gender");
				
				System.out.println("Doctor ID: " + doctorID);
				System.out.println("First name: " + first);
				System.out.println("Last name: " + last);
				System.out.println("Gender :" + gender);
			}
		} catch (SQLException e)
		{
			System.out.println("Doctor not found. Check output console");
			e.printStackTrace();
			return;
		}
	}
	else
	{if (option == 3)
	{
				// get input Admission Number
				System.out.println("Enter Admission number:");
				int inputNum = reader.nextInt();
				reader.close();
				
				// create prepared statements and execute them
				showAdmission = connection.prepareStatement("select * from Admission where admissionNum = ?");
				showAdmission.setInt(1,inputNum);
				AdmissionResult = showAdmission.executeQuery();
				
				showDoctors = connection.prepareStatement("select distinct * from Examine where admissionNum = ?");
				showDoctors.setInt(1,inputNum);
				DoctorsResult = showDoctors.executeQuery();
				
				showRooms = connection.prepareStatement("select * from StayIn where admissionNum = ?");
				showRooms.setInt(1,inputNum);
				RoomsResult = showAdmission.executeQuery();
				
				try
				{
					while (AdmissionResult.next())
					{
						String admissionNum = AdmissionResult.getString("admissionNum");
						int patientSSN = AdmissionResult.getInt("patientSSN");
						String admissionDate = AdmissionResult.getString("admissionDate");
						float totalPayment = AdmissionResult.getFloat("totalPayment");
						
						System.out.println("Admission Number: " + admissionNum);
						System.out.println("Patient SSN: " + patientSSN);
						System.out.println("Admission date (start date): " + admissionDate);
						System.out.println("Gender :" + totalPayment);
						
						try {
							System.out.println("Rooms: ");
							while (RoomsResult.next())
							{
								int roomNum = RoomsResult.getInt("roomNum");
								String fromDate = RoomsResult.getString("startDate");
								String toDate = RoomsResult.getString("endDate");
								
								System.out.println("RoomNum: " + roomNum + " FromDate: " + fromDate + " ToDate: " + toDate);
							}
						} catch (SQLException e)
						{
							System.out.println("Room not found. Check output console");
							e.printStackTrace();
							return;
						}
						
						try {
							System.out.println("Doctors examined the patient in this admission: ");
							while (DoctorsResult.next())
							{
								String doctorID = DoctorsResult.getString("doctorID");
								System.out.println("Doctor ID: " + doctorID);
							}
						} catch (SQLException e)
						{
							System.out.println("Doctor not found. Check output console");
							e.printStackTrace();
							return;
						}
					}
				} catch (SQLException e)
				{
					System.out.println("Admission not found. Check output console");
					e.printStackTrace();
					return;
				}
	}
	else
	{if (option == 4)
	{
		// get input Doctor ID
				System.out.println("Enter Admission Number: ");
				int inputAdmissionNum = reader.nextInt();
				System.out.println("Enter the new total payment: ");
				float inputTotal = reader.nextFloat();
				reader.close();
				
				// create prepared statement and execute it
				updateAdmission = connection.prepareStatement("update Admission set totalPayment = ? where admissionID = ?");
				updateAdmission.setFloat(1,inputTotal);
				updateAdmission.setInt(2,inputAdmissionNum);
				
				updateAdmission.executeUpdate();
				System.out.println("Update successful");
	}
	else 
	{
		System.out.println("Input option is invalid");
	}
	}
	}
	}
} catch (SQLException e){
	System.out.println("Error");
	e.printStackTrace();
	return;
}
try {
	if (showPatient != null) showPatient.close();
	if (showDoctor != null) showDoctor.close();
	if (showAdmission != null) showAdmission.close();
	if (showDoctors != null) showDoctors.close();
	if (showRooms != null) showRooms.close();
	if (updateAdmission != null) updateAdmission.close();
	if (result != null) result.close();
	if (AdmissionResult != null) AdmissionResult.close();
	if (DoctorsResult != null) DoctorsResult.close();
	if (RoomsResult != null) RoomsResult.close();
	if (connection != null) connection.close();
} catch (SQLException e){
	System.out.println("Cannot close connection!");
	e.printStackTrace();
}
}
}
