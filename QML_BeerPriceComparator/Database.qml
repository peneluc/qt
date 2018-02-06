import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id : database
    property var db :
        LocalStorage.openDatabaseSync("QBeerDB", "1.0", "Save information of Beer", 1000000)
               //Sql.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
                //    Opens or creates a local storage sql database by the given parameters.
                //      name is the database name
                //      version is the database version
                //      description is the database display name
                //      estimated_size is the database's estimated size, in bytes
                //      callback is an optional parameter, which is invoked if the database has not yet been created.
                //    Returns the created database object.

    signal beerRegistered(var beer)
    signal beerLoaded(var beers)

    Component.onCompleted: {
        connection()
    }

    Component.onDestruction: {
        console.log("*** encerrando a aplicacao ***")
    }

    function connection() {

        databaseValidation()

        console.log(">function connection() - " + database.db)

        database.db.transaction(
            function(tx){
                try {
                    console.log("DROP TABLE IF EXISTS Beer")
                    //tx.executeSql("DROP TABLE IF EXISTS Beer");
                }
                catch (err) {
                    console.log("Erro ao apagar tabela");
                }

                try {
                    console.log("CREATE TABLE IF NOT EXISTS Beer")
                    tx.executeSql("CREATE TABLE IF NOT EXISTS Beer(
                        id integer not null primary key autoincrement, nome TEXT,
                        volume TEXT, preco FLOAT, latitude FLOAT, longitude FLOAT)");
                }
                catch (err) {
                    console.log("Erro ao apagar tabela");
                }
            }
            )

        console.log("<function loadBeers()")

        loadBeers()
    }

    function databaseValidation()
    {
        console.log(">function databaseValidation()")

//        if(db.isOpen)
//        {
//            console.log("* banco de dados aberto")

//            console.log("db.connectionName() - " +	db.connectionName())
//            console.log("db.databaseName() - " +	db.databaseName())
//            console.log("db.driverName() - " +	db.driverName())
//            console.log("db.hostName() - " +	db.hostName())
//            console.log("db.isValid() - " +	db.isValid())
//            console.log("db.connectOptions() - " +	db.connectOptions())
//        }

        console.log("<function databaseValidation()")
    }

    function addBeer(nome, volume, preco, latitude, longitude){
        console.log(">function addBeer - nome:" + nome + " - volume:" + volume +
                    " - preco:" + preco + " - latitude:" + latitude + " - longitude:" + longitude)

        var rs = ({})
        database.db.transaction(function(tx){
          rs = tx.executeSql('INSERT INTO Beer VALUES(?,?,?,?,?,?)', [null, nome, volume, preco, latitude, longitude])
            beerRegistered({
                "itemId": parseInt(rs.insertId),
                "nome": nome,
                "volume": volume,
                "preco": parseFloat(preco),
                "latitude": parseFloat(latitude),
                "longitude": parseFloat(longitude)
            })
        })

        console.log("<function addBeer - rs.insertId: " + rs.insertId)
        return rs.insertId
    }

    function deleteBeer(id){
        console.log(">function deleteBeer(id) - " + id)

        var rs = {}
        database.db.transaction(function(tx){
            rs = tx.executeSql('DELETE FROM Beer WHERE id=?',[parseInt(id)])
        })

        console.log("<function deleteBeer(id) - rs: " + rs)
        return rs
    }

    function loadBeers(){
        console.log(">loadBeers() ")

        var rs = []
        database.db.transaction(function(tx){
            var results = tx.executeSql('SELECT * FROM Beer', [])
            for(var i = 0; i < results.rows.length; i++){
                var item = results.rows.item(i)
                var obj ={
                    "itemId": parseInt(item.id),
                    "nome": item.nome,
                    "volume": item.volume,
                    "preco": parseFloat(item.preco),
                    "latitude": parseFloat(item.latitude),
                    "longitude": parseFloat(item.longitude)
                }
                rs.push(obj)
                console.log("obj " +obj.itemId + " | " + obj.nome + " | " + obj.volume + " | " + obj.preco + " | " + obj.latitude + " | " + obj.longitude )
            }

        })

        console.log("<loadBeers() ")
        beerLoaded(rs)
    }

    function loadBeersJson(){
        console.log(">loadBeers() ")

        var rs = []
        var results = getJson()

        for(var i = 0; i < results.rows.length; i++){
            var item = results.rows.item(i)
            var obj ={
                "itemId": parseInt(item.id),
                "nome": item.nome,
                "volume": item.volume,
                "preco": parseFloat(item.preco),
                "latitude": parseFloat(item.latitude),
                "longitude": parseFloat(item.longitude)
            }
            rs.push(obj)
            console.log("obj " +obj.itemId + " | " + obj.nome + " | " + obj.volume + " | " + obj.preco + " | " + obj.latitude + " | " + obj.longitude )
        }

        console.log("<loadBeers() ")
        beerLoaded(rs)
    }
}
