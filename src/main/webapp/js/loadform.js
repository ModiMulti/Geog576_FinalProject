

function createReport(event) {
    event.preventDefault(); // stop form from submitting normally

    var a = $("#create_report_form").serializeArray();
    a.push({name: "tab_id", value: "0"});

    a = a.filter(function (item) {
        return item.value != '';


    });
    console.log(JSON.stringify(a));
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: a,
        success: function(reports){
            alert("The report is successfully submitted!");
            //
            showAllReports();

            document.getElementById("create_report_form").reset();
            $(".additional_msg_div").css({"visibility":"hidden"});

        },
        error: function(xhr, status, error) {
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
        url: 'HttpServlet',
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