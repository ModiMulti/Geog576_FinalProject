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
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAEj4xpbER0Q6wmyEwxN--Fi9pML0ckwh8&libraries=places,visualization&callback=initMap"></script>
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
                        <div><label>First Name*&nbsp</label><input placeholder="Your first name" name="reporter_fN"></div>
                        <div><label>Last Name*&nbsp</label><input placeholder="Your last name" name="reporter_lN"></div>
                        <div><label>Telephone&nbsp</label><input placeholder="Your telephone number" name="reporter_tel"></div>
                        <div><label>Email&nbsp</label><input placeholder="Your email address" name="reporter_email"></div>

                        <div><label>Safety Condition*</label>
                            <select name="safety_condition">
                                <option value="">Choose condition</option>
                                <option value="pothole">Pothole</option>
                                <option value="crocodile_cracking">Crocodile Cracking</option>
                                <option value="blind_junction">Blind Junction</option>
                                <option value="overgrown_vegetation">Overgrown Vegetation</option>
                                <option value="roadway_debris">Roadway Debris</option>
                                <option value="damaged_sidewalk">Damaged Sidewalk</option>
                                <option value="blocked_storm_drain">Blocked Storm Drain</option>
                                <option value="graffiti">Graffiti</option>
                                <option value="playground_equipment">Playground Equipment</option>
                                <option value="pedestrian_crossing">Pedestrian Crossing</option>
                                <option value="pedestrian_walkway_or_facility">Pedestrian Walkway or Facility</option>
                                <option value="other">Other</option>
                            </select>
                        </div>

                        <div><label>Action Required*</label>
                            <select name="action_required">
                                <option value="">Choose action</option>
                                <option value="cosmetic">Cosmetic</option>
                                <option value="inspection_needed">Inspection Needed</option>
                                <option value="maintenance_needed">Maintenance Needed</option>
                                <option value="safety_hazard">Safety Hazard</option>
                            </select>
                        </div>

                        <div><label>Description&nbsp</label><input placeholder="Please enter a description." name="description"></div>
                        <div><label>Locality&nbsp</label><input placeholder="Please the local place name." name="locality"></div>
                        <div><label>County&nbsp</label><input placeholder="Please enter the county." name="county"></div>
                        <div><label>State&nbsp</label><input placeholder="Please enter the state." name="state"></div>
                        <div><label>Latitude&nbsp</label><input id = "latitude" placeholder="Please click on the map for location." name="latitude"></div>
                        <div><label>Longitude&nbsp</label><input id="longitude" placeholder="Please click on the map for location." name="longitude"></div>
                        <button type="submit" class="btn btn-default" id="report_submit_btn">
                            <span class="glyphicon glyphicon-star"></span> Submit
                        </button>
                        <p>* indicates required item</p>
                    </form>
                </div>

                <!-- Query Report Tab Panel -->
                <div class="tab-pane" id="query_report">
                    <form id = "query_report_form">
                        <div><label>Safety Condition:</label>
                            <select name="safety_condition">
                                <option value="">Choose the Safety Condition</option>
                                <option value="pothole">Pothole</option>
                                <option value="crocodile_cracking">Crocodile Cracking</option>
                                <option value="blind_junction">Blind Junction</option>
                                <option value="overgrown_vegetation">Overgrown Vegetation</option>
                                <option value="roadway_debris">Roadway Debris</option>
                                <option value="damaged_sidewalk">Damaged Sidewalk</option>
                                <option value="blocked_storm_drain">Blocked Storm Drain</option>
                                <option value="graffiti">Graffiti</option>
                                <option value="playground_equipment">Playground Equipment</option>
                                <option value="pedestrian_crossing">Pedestrian Crossing</option>
                                <option value="pedestrian_walkway_or_facility">Pedestrian Walkway or Facility</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        <div><label>Action Required:</label>
                            <select name="action required">
                                <option value="">Choose the Action Required</option>
                                <option value="cosmetic">Cosmetic</option>
                                <option value="inspection_needed">Inspection Needed</option>
                                <option value="maintenance_needed">Maintenance Needed</option>
                                <option value="safety_hazard">Safety Hazard</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-default">
                            <span class="glyphicon glyphicon-star"></span> Submit the query
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div id="map-canvas" class="col-xs-9"></div>

    </div>
</div>

<script src="js/loadform.js"></script>
<script src="js/loadmap.js"></script>

</body>
</html>