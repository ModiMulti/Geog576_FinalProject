var map;
var place;
var autocomplete;
var infowindow = new google.maps.InfoWindow();
var report_lat;
var report_lon;
var gmarkers=[];

function initialization() {
    showAllReports();

}

function showAllReports() {
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: { "tab_id": "1"},
        success: function(reports) {
            mapInitialization(reports);
        },
        error: function(xhr, status, error) {
            alert("An AJAX error occured: " + status + "\nError: " + error);
        }
    });
}




function mapInitialization(reports) {
    var mapOptions = {
        mapTypeId : google.maps.MapTypeId.ROADMAP, // Set the type of Map
    };

    // Render the map within the empty div
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    var bounds = new google.maps.LatLngBounds ();

    google.maps.event.addListener(map, "click", function (event) {
        var location = event.latLng;

        marker = new google.maps.Marker({
            position: location,
            map: map
        });
        gmarkers.push(marker);
        report_lat = location.lat();
        report_lon = location.lng();
        $("#latitude").attr('value', report_lat);
        $("#longitude").attr('value',report_lon);
        oneMarker(gmarkers);



        //Attach click event handler to the marker.
        google.maps.event.addListener(marker, "click", function (event) {
            var infoWindow = new google.maps.InfoWindow({
                content: 'Latitude: ' + location.lat() + '<br />Longitude: ' + location.lng()

            });
            infoWindow.open(map, marker);
        });
    });


    $.each(reports, function(i, e) {
        var long = Number(e['longitude']);
        var lat = Number(e['latitude']);
        var latlng = new google.maps.LatLng(lat, long);

        bounds.extend(latlng);

        // Create the infoWindow content
        var contentStr = '<h4>Report Details</h4><hr>';
        contentStr += '<p><b>' + 'Safety Condition' + ':</b>&nbsp' + e['safety_condition'].replace(/_/g, ' ') + '</p>';
        contentStr += '<p><b>' + 'Action Required' + ':</b>&nbsp' + e['action_required'].replace(/_/g, ' ') +
            '</p>';
        if (e['action_required'] == 'cosmetic' || e['action_required'] == 'inspection needed' || e['action_required'] == 'maintenance needed' || e['action_required'] == 'safety hazard' )  {
            contentStr += '<p><b>' + 'Locality' + ':</b>&nbsp' +
                e['locality'] + '</p>'; contentStr += '<p><b>' + 'County' + ':</b>&nbsp' +
                e['county'] + '</p>'; contentStr += '<p><b>' + 'State' + ':</b>&nbsp' +
                e['state'] + '</p>';
        }
        else if (e['action_required'] == 'maintenance_needed' || e['action_required'] == 'inspection_needed' || e['action_required'] == 'safety_hazard') {
            contentStr += '<p><b>' + 'Locality' + ':</b>&nbsp' +
                e['locality'] + '</p>'; contentStr += '<p><b>' + 'County' + ':</b>&nbsp' +
                e['county'] + '</p>'; contentStr += '<p><b>' + 'State' + ':</b>&nbsp' +
                e['state'] + '</p>';
        }


        contentStr += '<p><b>' + 'Reporter' + ':</b>&nbsp' + e['first_name'] + '&nbsp' + e['last_name'] + '</p>';

        contentStr += '<p><b>' + 'Timestamp' + ':</b>&nbsp' +
            e['report_date'].substring(0,19) + '</p>';
        if ('description' in e){
            contentStr += '<p><b>' + 'Description' + ':</b>&nbsp' + e['description'] + '</p>';
        }


        var icon_img = '';

        if(e['action_required'] == 'cosmetic') {
            icon_img = 'http://maps.google.com/mapfiles/kml/paddle/grn-blank.png';
        }else if(e['action_required'] == 'inspection needed' || e['action_required'] == 'inspection_needed'){
            icon_img = 'http://maps.google.com/mapfiles/kml/paddle/ylw-blank.png';
        }else if(e['action_required'] == 'maintenance needed' || e['action_required'] == 'maintenance_needed'){
            icon_img = 'http://maps.google.com/mapfiles/kml/paddle/orange-blank.png';
        }else if(e['action_required'] == 'safety hazard' || e['action_required'] == 'safety_hazard'){
            icon_img = 'http://maps.google.com/mapfiles/kml/paddle/red-stars.png';
        }

        var icon = {
            url: icon_img, // url
            scaledSize: new google.maps.Size(15, 10), // scaled size
            origin: new google.maps.Point(0, 0), // origin
            anchor: new google.maps.Point(0, 0) // anchor
        };

        // Create the marker
        var marker = new google.maps.Marker({ // Set the marker
            position : latlng, // Position marker to coordinates
            map : map, // assign the market to our map variable
            icon: icon_img,
            customInfo: contentStr
        });

        // Add a Click Listener to the marker
        google.maps.event.addListener(marker, 'click', function() {
            // use 'customInfo' to customize infoWindow
            infowindow.setContent(marker['customInfo']);
            infowindow.open(map, marker); // Open InfoWindow
        });

    });

    map.fitBounds (bounds);

}

function oneMarker(m){
    for(i=0; i<gmarkers.length-1; i++){
        gmarkers[i].setMap(null);
    }
};

//Answer - Question 3 - Lab 6
function onPlaceChanged() {
    infowindow.close();
    place = autocomplete.getPlace();

    if (!place.geometry || !place.geometry.location) {
        // User entered the name of a Place that was not suggested and
        // pressed the Enter key, or the Place Details request failed.
        window.alert("No details available for input: '" + place.name + "'");
        return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
    } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);
    }
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);
    infowindowContent.children["place-name"].textContent = place.name;
    infowindowContent.children["place-address"].textContent =
        place.formatted_address;
    infowindow.open(map, marker);
}

//Execute our 'initialization' function once the page has loaded.
google.maps.event.addDomListener(window, 'load', initialization);