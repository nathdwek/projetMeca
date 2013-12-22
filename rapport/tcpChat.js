var net = require('net');

var sockets = [];
serv = net.createServer(function(socket) {
   for (var i = 0; i<sockets.length; i++){
      sockets[i].write("Quelqu'un a rejoint le chat\n");
   }
   socket.write("Vous avez rejoint le chat\n");
   sockets.push(socket);
   socket.on('data', function(data){
      for (var i = 0; i<sockets.length; i++){
         if (sockets[i]!=socket){
            sockets[i].write(data);
         }
      }
   });
   socket.on('end', function(){
      var j = sockets.indexOf(socket);
      sockets.splice(j,1);
      for (var i= 0; i<sockets.length; i++){
         sockets[i].write("Quelqu'un a quitté le chat\n");
      }
});

});


serv.listen(8197);
