import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id: json

    signal beerRegistered(var beer)
    signal beerLoaded(var beers)

    Component.onCompleted: {
        console.log("*** iniciando componente json ***")
    }

    Component.onDestruction: {
        console.log("*** encerrando componente json ***")
    }

    function getJson()
    {
            request('http://agora-server.herokuapp.com/beersales', function (o) {

                // log the json response
                console.log(o.responseText);

                // translate response into object
                var d = eval('new Object(' + o.responseText + ')');
            });

        return d;
    }

    // this function is included locally, but you can also include separately via a header definition
    function request(url, callback) {
        var xhr = new XMLHttpRequest();

            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.setRequestHeader("Content-length", params.length);
            xhr.setRequestHeader("Connection", "close");

        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                  if(myxhr.readyState === 4) callback(myxhr)
                      if (myxhr.status === 200) {
                          console.log("ok")
                      } else {
                          console.log("error: " + http.status)
                      }
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }
}
