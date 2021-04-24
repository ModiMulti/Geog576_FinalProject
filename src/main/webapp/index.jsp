<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Community Improvement</title>

    <!-- Custom styles -->
    <link rel="stylesheet" href="css/style.css">

    <!-- jQuery -->

    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <!-- Google Map js libraries-->
    <script src="https://maps.googleapis.com/maps/api/js?key=API_KEY&libraries=places,visualization&callback=initMap"></script>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <a class="navbar-brand">Community Improvement Portal</a>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="sidebar col-xs-3">

            <!-- Tab Navis-->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#create_report" data-toggle="tab">Create Report</a></li>
                <li><a href="#query_report" data-toggle="tab">Query</a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content ">
                <!-- Create Report Tab Panel -->
                <div class="tab-pane active" id="create_report">
                    <form id = "create_report_form">
                        <div><label>First Name:&nbsp</label><input placeholder="Your first name" name="fN"></div>
                        <div><label>Last Name:&nbsp</label><input placeholder="Your last name" name="lN"></div>
                        <div><label>Tel:&nbsp</label><input placeholder="Your telephone number" name="tel"></div>
                        <div><label>Email:&nbsp</label><input placeholder="Your email address" name="email"></div>
                        <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
                            <select class="additional_msg_select" name="additional_message"></select>
                        </div>
                        <div><label>Action Required:</label>
                            <select name="action_required">
                                <option value="">Choose action</option>
                                <option value="cosmetic">cosmetic</option>
                                <option value="inspection">inspection needed</option>
                                <option value="maintenance">maintenance needed</option>
                                <option value="hazard">safety hazard</option>
                            </select>
                        </div>
                        <div><label>Safety Condition::</label>
                            <select onchange="onSelectReportType(this)" name="safety_condition">
                                <option value="">Choose condition</option>
                                <option value="pothole">pothole</option>
                                <option value="cracking">crocodile cracking</option>
                                <option value="blind">blind junction</option>
                                <option value="overgrown">overgrown vegetation</option>
                                <option value="debris">roadway debris</option>
                                <option value="sidewalkdmg">damaged sidewalk</option>
                                <option value="drain">blocked storm drain</option>
                                <option value="graffiti">graffiti</option>
                                <option value="playground">playground equipment</option>
                                <option value="pedx">pedestrian crossing</option>
                                <option value="pedwalkway">pedestrian walkway or facility</option>
                                <option value="other">other</option>
                            </select>
                        </div>
                        <div><label>Address:</label>
                            <input id="autocomplete" placeholder="Address" >
                        </div>

                        <button type="submit" class="btn btn-default" id="report_submit_btn">
                            <span class="glyphicon glyphicon-star"></span> Submit
                        </button>
                    </form>
                </div>

                <%--<!-- Query Report Tab Panel -->
                <div class="tab-pane" id="query_report">
                    <form id = "query_report_form">
                        <div><label>Report Type:</label>
                            <select onchange="onSelectReportType(this)" name="report_type">
                                <option value="">Choose the report type</option>
                                <option value="donation">Donation</option>
                                <option value="request">Request</option>
                                <option value="damage">Damage Report</option>
                            </select>
                        </div>
                        <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
                            <select class="additional_msg_select" name="resource_or_damage"></select>
                        </div>
                        <div><label>Disaster Type:</label>
                            <select name="disaster_type">
                                <option value="">Choose the disaster type</option>
                                <option value="flood">flood</option>
                                <option value="wildfire">wildfire</option>
                                <option value="earthquake">earthquake</option>
                                <option value="tornado">tornado</option>
                                <option value="hurricane">hurricane</option>
                                <option value="other">other</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-default">
                            <span class="glyphicon glyphicon-star"></span> Submit the query
                        </button>
                    </form>
                </div>--%>
            </div>
        </div>

        <div id="map-canvas" class="col-xs-9"></div>

    </div>
</div>

<script src="js/loadform.js"></script>
<script src="js/loadmap.js"></script>

<script>
    window.onload = tests();
    function tests() {
        test_report_submission();
        test_query_report();
    }

/*    function test_report_submission() {
        $.ajax({
            url: 'RunQuery.jsp',
            type: 'POST',
            data: { "tab_id": "0", "fN": "Jason", "lN": "Zhou",  "is_male": "t",
                "age": "30", "blood_type": "AB", "tel": "928-777-8856", "email":
                    "jasonzhou@gmail.com", "contact_fN": "Bill", "contact_lN": "Huang",
                "contact_tel": "608-888-9876", "contact_email": "billh@gmail.com",
                "report_type": "request", "disaster_type": "wildfire", "longitude":
                    "-87", "latitude": "33", "message": "request rescue!!!",
                "additional_message": "rescue/volunteer"},
            success: function(data){
                $.each(data, function(i, name) {
                    alert("key: " + i + ", value: " + name);
                });
            },
            error: function(xhr, status, error) {
                alert("An AJAX error occured: " + status + "\nError: " + error);
            }
        });
    }*/

    /*function test_report_submission() {
        $.ajax({
            url: 'RunQuery.jsp',
            type: 'POST',
            data: { "tab_id": "0", "fN": "Dannis", "lN": "Black", "report_type": "damage",
                "disaster_type": "hurricane", "longitude": "26.89", "latitude": "35.12", "additional_message": "pollution"},
            success: function(data){
                $.each(data, function(i, name) {
                    alert("key: " + i + ", value: " + name);
                });
            },
            error: function(xhr, status, error) {
                alert("An AJAX error occured: " + status + "\nError: " + error);
            }
        });
    }*/

    /*function test_query_report() {
        $.ajax({
            url: 'RunQuery.jsp',
            type: 'POST',
            data: { "tab_id": "1", "disaster_type": "hurricane", "report_type":
                    "donation",  "resource_or_damage": "food"},
            success: function(data){
                $.each(data, function(i, e) {
                    alert(JSON.stringify(e));
                });
            },
            error: function(xhr, status, error) {
                alert("An AJAX error occured: " + status + "\nError: " + error);
            }
        });*/


    /*function test_query_report() {
        $.ajax({
            url: 'HttpServlet',
            type: 'POST',
            data: { "tab_id": "1", "disaster_type": "hurricane", "report_type": "damage"},
            success: function(data){
                $.each(data, function(i, e) {
                    alert(JSON.stringify(e));
                });
            },
            error: function(xhr, status, error) {
                alert("An AJAX error occured: " + status + "\nError: " + error);
            }
        });*/
</script>
</body>
</html>