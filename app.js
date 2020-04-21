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
    sess.login="Login Out";
    sess.login_re='/logout';
  }
  else{
    console.log("else");
    sess.login="Login In";
    sess.login_re='/login';
    sess.name="Guest";

  }
  res.render('home',{sess:sess});
});

app.get("/contact",function(req,res){
  res.sendFile(__dirname+"/contact.html");
});

app.get("/staff",function(req,res){
  let sql= "SELECT * from boookings ";
   connection.query(sql,function(er, rows,fields){
     if(er){
       console.log("Can't SELECT");
       console.log(er);
     }
     else{
       //var j=JSON.parse(rows);
       var x;
       for(x in rows){
         console.log(rows[x]);
       }
      // console.log(j);
       res.render("list",{data:rows});
     //console.log(j);
   }
   });
});

app.get("/login",function(req,res){
  res.sendFile(__dirname+"/login.html");
});


app.post("/logged",function(req,res){
  var user=req.body.username;
  var pass=req.body.password;


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
        res.redirect('/login');
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
//        res.write("Hi "+row[0].First_Name+" we missed you!");

      }


    }
  });

});

app.post("/sucessful",function(req,res){
  var sess=req.session;
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
        res.render("success",{sess:sess});
      }
    });


});

app.get("/cart",function(req,res){
  var sess=req.session;
  console.log(sess.booking);
  res.render('cart',{sess:sess});
});

app.get("/logout",function(req,res){
  req.session.destroy();
  res.redirect("/home");
});


app.post("/registered",function(req,res){
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
});


app.post('/cart',function(req,res){
  console.log(req.body);
  let name=req.body.name;
  let countOfRooms=req.body.countOfRooms;
  let days=req.body.days;
  let checkInDate=req.body.checkInDate;
  let checkInTime=req.body.checkInTime;
  let checkOutDate=req.body.checkOutDate;
  let room=req.body.RoomID;
  console.log(typeof(checkInDate));
  let values={'name':name,
              'RoomID':room,
              "countOfRooms":countOfRooms,
              "days":days,
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
  res.sendFile(__dirname+"/index.html");
});
app.listen(3000,function(err){
    if(!!err){
      console.log("ERROR");
    }
    else{
    console.log("Server Running on port 3000");
    }
});
