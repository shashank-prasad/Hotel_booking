//jshint esversion:6
const express=require("express");
const mysql=require("mysql");
const bodyParser=require('body-parser');
const session = require('express-session');

var app=express();
app.use('/', express.static('public'));
app.set("view engine",'ejs');
app.use(bodyParser.urlencoded({extended:true}));
app.use( bodyParser.json() );
app.use(session({secret: 'ssshhhhh',saveUninitialized: true,resave: true}));


var sess; //GLOBAL

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
        res.write("USERNAME and Password is wrong ");
      }else{
        //SESSION CREATED
          sess=req.session;
          sess.email=user;
        res.write("<h1>You are logged in as User</h1>");
        console.log(row[0]);
        res.write("Hi "+row[0].First_Name+" we missed you!");

      }

      res.send();
    }
  });

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
