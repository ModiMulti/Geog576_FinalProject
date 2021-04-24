function onSelectReportType(ele){
    var form = $(ele).parent().parent();
    var label = $(form).find(".additional_msg");
    var select = $(form).find(".additional_msg_select");

    switch (ele.value) {
        case "donation":
        case "request":
            label.text("Resource Type:");
            select.find('option').remove();
            select.append($("<option></option>")
                .attr("value","")
                .text("Choose the resource type"));
            selectValues = ['water', 'food', 'money', 'medicine', 'cloth',
                'rescue/volunteer'];
            $.each(selectValues, function(index,value) {
                select.append($("<option></option>")
                    .attr("value",value)
                    .text(value));
            });
            break;
        case "damage":
            label.text("Damage Type:");
            select.find('option').remove();
            select.append($("<option></option>")
                .attr("value","")
                .text("Choose the damage type"));
            selectValues = ['pollution', 'building damage', 'road damage', 'casualty',
                'other'];
            $.each(selectValues, function(index,value) {
                select.append($("<option></option>")
                    .attr("value",value)
                    .text(value));
            });
            break;
        default:
            $(form).find(".additional_msg_div").css("visibility", "hidden");
            return;
    }
    $(form).find(".additional_msg_div").css("visibility", "visible");
}

// Answer - Question 4 - Lab 6
function createReport(event) {
    event.preventDefault(); // stop form from submitting normally

    var a = $("#create_report_form").serializeArray();
    a.push({name: "tab_id", value: "0"});
    a.push({name: "longitude", value: place.geometry.location.lng()});
    a.push({name: "latitude", value: place.geometry.location.lat()});
    a = a.filter(function (item) {
        return item.value != '';
    });

    $.ajax({
        url: 'RunQuery.jsp',
        type: 'POST',
        data: a,
        success: function (report) {
            $.ajax({
                url: 'RunQuery.jsp',
                type: 'POST',
                data: {"tab_id": "1"},
                success: function (reports) {
                    alert("The report is successfully submitted!");
                    mapInitialization(reports);

                    // Answer - Question 4 - Bonus - Lab 6
                    onPlaceChanged();
                },
                error: function (xhr, status, error) {
                    alert("An AJAX error occurred:" + status + "\nError: " + error);
                }
            });
            document.getElementById("create_report_form").reset();
            $("#create_report_form").find(".additional_msg_div").css("visibility", "hidden");
        },
        error: function (xhr, status, error) {
            alert("Status: " + status + "\nError: " + error);
        }
    });
}

$("#create_report_form").on("submit",createReport);

function queryReport(event) {
    event.preventDefault(); // stop form from submitting normally

    var a = $("#query_report_form").serializeArray();
    a.push({ name: "tab_id", value: "1" });
    a = a.filter(function(item){return item.value != '';});
    $.ajax({
        url: 'RunQuery.jsp',
        type: 'POST',
        data: a,
        success: function(reports) {
            mapInitialization(reports);
        },
        error: function(xhr, status, error) {
            alert("Status: " + status + "\nError: " + error);
        }
    });
}

$("#query_report_form").on("submit",queryReport);