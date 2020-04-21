//jshint esversion:6
const express=require("express");
const mysql=require("mysql");
const bodyParser=require('body-parser');
const session = require('express-session');


var app=express();
app.use('/', express.static('public'));
app.use(express.static(__dirname + '/views'));
app.set("view engine",'ejs');
app.use(bodyParser.urlencoded({extended:true}));
app.use( bodyParser.json() );
app.use(session({secret: 'ssshhhhh',saveUninitialized: true,resave: true}));


//var sess; //GLOBAL

var connection=mysql.createConnection({
  host:"localhost",
  port : 3306,
  user:"root",
  password:"",
  database : "mydb"
});

connection.connect(function(error){
  if(error){
    console.log(error);  //Ye output aara hai humesha

  }else{
    console.log("Connected");
	}
});

//connection.on('error', function(err) {
//  console.log("[mysql error]",err);
//});

app.get("/book",function(req,res){
  res.sendFile(__dirname+"/book.html");
});

app.get("/home",function(req,res){
  var sess=req.session;


  if(sess.email){
    console.log("if");
    sess.login="Log Out";
    sess.login_re='/logout';
    sess.b="/my_booking";
  }
  else{
    console.log("else");
    sess.login="Log In";
    sess.login_re='/login';
    sess.name="Guest";
    sess.b="/login";
  }

  let sql="SELECT * FROM rooms";
  connection.query(sql,function(er,rows,fields){
    if(er){
      console.log(er);
    }else{

      sess.room_data=rows;
      console.log("ROW DATA: ");
      console.log(sess.room_data);
      res.render('home',{sess:sess});
    }
  });
});

app.get("/contact",function(req,res){
  res.sendFile(__dirname+"/contact.html");
});


app.get("/my_booking",function(req,res){
  let sess=req.session;
  console.log(sess.userid);
  let sql= "SELECT * from bookings WHERE ClientID=?";
  let rooms=["Single Room","Single Room","Super Deluxe Room","Executive Suite","Garden Suite","President Suite"];
  let uid=sess.userid;
  console.log(rooms[0]);
  connection.query(sql,[uid],function(er, rows,fields){
    if(er){
      console.log("Can't SELECT");
      console.log(er);
    }
    else{
      var x;

      for(x in rows){
        console.log(rows[x]);
      }
      res.render("bookings_log",{data:rows, sess:sess,rooms:rooms});
  }
  });
});



app.get("/staff",function(req,res){
  var sess=req.session;

  let sql= "SELECT * from bookings ";
   connection.query(sql,function(er, rows,fields){
     if(er){
       console.log("Can't SELECT");
       console.log(er);
     }
     else{
       var x;

       for(x in rows){
         console.log(rows[x]);
       }
       res.render("list",{data:rows, sess:sess});
   }
   });
});

app.get("/login",function(req,res){

  var sess=req.session;
  sess.wrong_login="";
  res.render("login",{sess:sess});
});


app.post("/logged",function(req,res){
  var user=req.body.username;
  var pass=req.body.password;

  let sess=req.session;
  console.log(user);
  console.log(pass);

  let sql="SELECT * FROM clients WHERE username= ? AND password= ?";
  connection.query(sql,[user,pass],function(err,row,field){
    if(err){
      console.log("Can't login");
      console.log(err);
    }
    else{
      //console.log(row.length);
      if(row.length==0){
        //window.alert("Username or Password is incorrect try again");
        console.log("WRONG PASSWORD");
        let sess=req.session;
        sess.wrong_login="*Invalid Username or password, Try Again!";
        res.render("login",{sess:sess});
      }else{
        //SESSION CREATED
          console.log("SESSION CREATED");
          var sess=req.session;
          sess.email=row[0].Email;
          sess.name=row[0].First_Name;
          sess.userid=row[0].ClientID;
        console.log(row[0]);

        if(sess.booking)
        {
          res.redirect('/payment');
        }
        else{
        res.redirect("/home");
        }
      }
    }
  });

});

app.post("/sucessful",function(req,res){
  var sess=req.session;
  let card_no=req.body.card_number;
  let exp_date=req.body.exp_date;
  let cvc=req.body.cvc;
  let name=req.body.name;



  console.log("DDOONNNEE" +"for "+sess.userid);
  console.log(sess.booking);

  let book_values=[[sess.userid,sess.booking.name,sess.booking.RoomID,
    sess.booking.countOfRooms,sess.booking.checkInDate,
    sess.booking.checkInTime,sess.booking.checkOutDate,sess.booking.days]];
  console.log(book_values);




    let sql="INSERT INTO bookings (ClientID,Name,RoomID,NumberOfRooms,checkInDate,checkInTime,checkOutDate,Days) VALUES ?";
    connection.query(sql,[book_values],function(err,result){
      if(err){
        console.log(err);
      }
      else{
        console.log("Entry of "+book_values+" completed sucessfully!");
        console.log(result);

        connection.query("SELECT BookingID FROM Bookings ORDER BY BookingID DESC LIMIT 1",function(er,row,field){
          if(er){
            console.log(er);
          }else{
            console.log(row[0].BookingID);
            console.log(row);
            let bid=row[0].BookingID;
            let insert="INSERT INTO payment (BookingID,Card_Number,Card_Expiration_date,CVV,Owner_name) VALUES ?";
            let pay=[[bid,card_no,exp_date,cvc,name]];
            connection.query(insert,[pay],function(e,result2){
              if(e){
                console.log(e);
              }else{
                console.log("PAYMENT ADDED");
              }
            });
          }
        });


        res.render("success",{sess:sess});
      }
    });


});

app.get("/cart",function(req,res){
  var sess=req.session;
  console.log(sess.booking);
  sess.room_pic_path="assets/img/rooms/room_"+sess.booking.RoomID+".jpeg";
  console.log(sess.room_pic_path);
  res.render('cart',{sess:sess});
});

app.get("/logout",function(req,res){
  req.session.destroy();
  res.redirect("/home");
});


app.post("/registered",function(req,res){
  let sess=req.session;
  //first_name
  //last_name
  //dateOfBirth
  let fname=req.body.first_name;
  let lname=req.body.last_name;
  let dateOfBirth=req.body.dateOfBirth;
  let gender=req.body.gender;
  let mail=req.body.email;
  let phone=req.body.phone;
  let user=req.body.user_name;
  let pass=req.body.password;

  let check_query= "SELECT * from clients WHERE Email=? OR username=? ";
  let check=[[mail,user]];

connection.query(check_query,[mail,user],function(er,rows,fields){
  if(er){
    console.log(er);
  }else{
    if(rows.length!=0){
      console.log(user);
      console.log(mail);
      console.log("ALREADY IN USE");
      sess.alert="*Username or Email ID Already Exits";
      res.render("register",{sess:sess});
    }else{
      let values=[[fname,lname,dateOfBirth,gender,mail,phone,user,pass]];


      let sql="INSERT INTO clients (First_Name,Last_Name,DOB,Gender,Email,Contact_Number,username,password) VALUES ?";
      connection.query(sql,[values],function(err,result){
        if(err){
          console.log(err);
        }
        else{
          console.log("Entry of "+fname+" completed sucessfully!");
          console.log(result);
          res.redirect("/login");
        }
      });
    }
  }
});

});


app.post('/cart',function(req,res){
  console.log(req.body);
  let name=req.body.name;
  let countOfRooms=req.body.countOfRooms;
  let checkInDate=req.body.checkInDate;
  let checkInTime=req.body.checkInTime;
  let checkOutDate=req.body.checkOutDate;
  let room=req.body.RoomID;


 var NtpDate = new Date(checkInDate);
var ReportDate = new Date(checkOutDate);
var timeDiff = Math.abs(ReportDate.getTime() - NtpDate.getTime());
var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
 //alert(diffDays);
console.log("Period =" + diffDays );


  console.log(typeof(checkInDate));
  let values={'name':name,
              'RoomID':room,
              "countOfRooms":countOfRooms,
              "days":diffDays,
              "checkInDate":checkInDate,
              "checkInTime":checkInTime,
              "checkOutDate":checkOutDate
            };
  var sess=req.session;
  sess.booking=values;

  let sql="SELECT * from rooms WHERE RoomID=?  ";
  connection.query(sql,[room],function(err,row,field){
    if(err){
      console.log(sql);
      console.log(err);
    }
    else{
      console.log(sql);
      console.log("Entry of "+name+" completed sucessfully!");
      console.log(row);
      sess.queryResult=row[0];
    }

  res.redirect('/cart');
});


app.get("/payment",function(req,res){
  var sess=req.session;
  console.log(sess);
  console.log(sess.email);
  if(sess.email){
    res.sendFile(__dirname+"/creditcard.html");
  }else{
    res.redirect("/login");
  }
});

});

app.get("/register",function(req,res){

  let sess=req.session;
      sess.alert="";
      res.render("register",{sess:sess});
});

app.listen(3000,function(err){
    if(!!err){
      console.log("ERROR");
    }
    else{
    console.log("Server Running on port 3000");
    }
});
