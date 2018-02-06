import QtQuick 1.1

Rectangle {
    Component.onCompleted: {
        var http = new XMLHttpRequest()
        var url = "http://agora-server.herokuapp.com/beersales";
        var params = "num=22&num2=333";
        http.open("POST", url, true);

        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");

        http.onreadystatechange = function() { // Call a function when the state changes.
                    if (http.readyState == 4) {
                        if (http.status == 200) {
                            console.log("ok")
                        } else {
                            console.log("error: " + http.status)
                        }
                    }
                }
        http.send(params);
    }
}
