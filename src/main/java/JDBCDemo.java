import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCDemo {

    public static void main(String[] args) {
        Connection conn;
        Statement stmt;
        try {
            // load the JDBC driver
            Class.forName("org.postgresql.Driver");

            // establish connection
            String url = "jdbc:postgresql://geo576final.cyvjwyqynbfu.us-east-2.rds.amazonaws.com:5432/geo576";
            conn = DriverManager.getConnection(url, "appuser", "geo576");

            // query the database
            String sql = "select safety_condition, description, action_required, report_date, " +
                    "ST_AsText(geom) as geom from geo576.report";
            stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);

            // print the result
            if (res != null) {
                while (res.next()) {
                    System.out.println("safety_condition: " + res.getString("safety_condition"));
                    System.out.println("description: " + res.getString("description"));
                    System.out.println("action_required: " + res.getString("action_required"));
                    System.out.println("report_date: " + res.getString("report_date"));
                    System.out.println("geom: " + res.getString("geom"));
                }
            }

            // clean up
            stmt.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}