package org.webproject.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.webproject.servlet.DBUtility;

/**
 * Servlet implementation class HttpServlet
 */
@WebServlet("/HttpServlet")
public class HttpServlet extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see javax.servlet.http.HttpServlet#javax.servlet.http.HttpServlet()
     */
    public HttpServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String tab_id = request.getParameter("tab_id");

        // create a report
        if (tab_id.equals("0")) {
            System.out.println("A report is submitted!");
            try {
                createReport(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // query reports
        else if (tab_id.equals("1")) {
            try {
                queryReport(request, response);
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    private void createReport(HttpServletRequest request, HttpServletResponse
            response) throws SQLException, IOException {
        DBUtility dbutil = new DBUtility();
        String sql;

        // 1. create reporter
        int reporter_id = 0;
        String reporter_fName = request.getParameter("reporter_fN");
        String reporter_lName = request.getParameter("reporter_lN");
        String reporter_phone = request.getParameter("reporter_tel");
        String reporter_email = request.getParameter("reporter_email");
        if (reporter_fName != null) {reporter_fName = "'" + reporter_fName + "'";}
        if (reporter_lName != null) {reporter_lName = "'" + reporter_lName + "'";}
        if (reporter_phone != null) {reporter_phone = "'" + reporter_phone + "'";}
        if (reporter_email != null) {reporter_email = "'" + reporter_email + "'";}
        if (reporter_fName != null && reporter_lName != null) {
            // create the reporter
           sql = "insert into geo576.reporter (first_name, last_name, email, phone_num) " +
                    "values (" + reporter_fName + "," + reporter_lName + "," + reporter_email + "," +
                    reporter_phone + ")";




            /*sql = "insert into reporter (first_name, last_name, email, phone_num) " +
                    "values (" + reporter_fName + "," + reporter_lName + "," + reporter_email + "," +
                    reporter_phone + ")";

             */
            dbutil.modifyDB(sql);

            // record the reporter id
            ResultSet res_1 = dbutil.queryDB("select last_value from geo576.reporter_id_seq");
            //ResultSet res_1 = dbutil.queryDB("select last_value from reporter_id_seq");
            res_1.next();
            reporter_id = res_1.getInt(1);

            System.out.println("Reporter Successfully created.");
        }

        // 2. create report
        int report_id = 0;
        String safety_cond = request.getParameter("safety_condition");
        String desc = request.getParameter("description");
        String act_req = request.getParameter("action_required");
        String local = request.getParameter("locality");
        String county = request.getParameter("county");
        String state = request.getParameter("state");
        String lon = request.getParameter("longitude");
        String lat = request.getParameter("latitude");
        System.out.println("pre-parameters " + safety_cond + " " + desc + " " + act_req + " " +  local + " " +  county + " "  + state + " " + lon + " " + lat);
        if (safety_cond != null) {safety_cond =  "'" + safety_cond + "'";}
        if (desc != null) {desc = "'" + desc + "'";}
        if (act_req != null) {act_req = "'" + act_req + "'";}
        if (local != null) {local = "'" + local + "'";}
        if (county != null) {county = "'" + county + "'";}
        if (state != null) {state = "'" + state + "'";}

        sql = "insert into geo576.report (reporter, safety_condition, description, action_required," +
                "locality, county, state, geom) values (" + reporter_id + "," + safety_cond + "," + desc + "," +
                act_req + "," + local + "," + county + "," + state
                + ", ST_GeomFromText('POINT(" + lon + " " + lat + ")', 4326))";

        System.out.println(sql);

        /*
        sql = "insert into report (reporter, safety_condition, description, action_required," +
                "locality, county, state, geom) values (" + reporter_id + "," + safety_cond + "," + desc +
                act_req + "," + local + "," + county + "," + state
                + ", ST_GeomFromText('POINT(" + 35 + " " + -47 + ")', 4326))";

         */
        dbutil.modifyDB(sql);

        // record report_id
        ResultSet res_2 = dbutil.queryDB("select last_value from geo576.report_id_seq");
        //ResultSet res_2 = dbutil.queryDB("select last_value from report_id_seq");
        res_2.next();
        report_id = res_2.getInt(1);

        System.out.println("Success! Report created.");



        // response that the report submission is successful
        JSONObject data = new JSONObject();
        try {
            data.put("status", "success");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        response.getWriter().write(data.toString());

    }

    private void queryReport(HttpServletRequest request, HttpServletResponse
            response) throws JSONException, SQLException, IOException {
        JSONArray list = new JSONArray();

        String safety_cond = request.getParameter("safety_condition");
        String action_req = request.getParameter("action_required");



        // request report

       String sql = "select safety_condition, description, action_required, report_date, " +
               "reporter.first_name, reporter.last_name, reporter.email, reporter.phone_num, " +
               "locality, county, state, ST_X(geom) as longitude, ST_Y(geom) as latitude from geo576.report report join geo576.reporter reporter " +
               "on report.reporter = reporter.id";


        /*
        String sql = "select safety_condition, description, action_required, report_date, " +
                "reporter.first_name, reporter.last_name, reporter.email, reporter.phone_num, " +
                "locality, county, state, ST_X(geom) as longitude, ST_Y(geom) as latitude from report join reporter " +
                "on report.reporter = reporter.id";

         */



        queryReportHelper(sql,list,safety_cond,action_req);


        response.getWriter().write(list.toString());
    }

    private void queryReportHelper(String sql, JSONArray list, String safety_cond,
                                   String action_req) throws SQLException {
        DBUtility dbutil = new DBUtility();
        if (safety_cond != null) {
            if (action_req != null) {
                sql += " where safety_condition = '" + safety_cond + "' and action_required = '" + action_req + "'";
            } else {
                sql += " where safety_condition = '" + safety_cond + "'";
            }
        } else {
            if (action_req != null) {
                sql += " where action_required = '" + action_req + "'";

            }
        }

        ResultSet res = dbutil.queryDB(sql);
        while (res.next()) {
            // add to response
            HashMap<String, String> m = new HashMap<String,String>();
            //m.put("report_id", res.getString("id"));
            m.put("safety_condition", res.getString("safety_condition"));
            m.put("description", res.getString("description"));
            m.put("action_required", res.getString("action_required"));
            m.put("report_date", res.getString("report_date"));
            m.put("locality", res.getString("locality"));
            m.put("county", res.getString("county"));
            m.put("state", res.getString("state"));
            m.put("latitude", res.getString("latitude"));
            m.put("longitude", res.getString("longitude"));
            m.put("first_name", res.getString("first_name"));
            m.put("last_name", res.getString("last_name"));
            m.put("email", res.getString("email"));
            m.put("phone_num", res.getString("phone_num"));
            list.put(m);
        }
    }

    public void main() throws JSONException {
    }
}