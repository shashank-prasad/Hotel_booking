function validate()
{
  var dob_entry=document.forms["register"]["dateOfBirth"].value;
  var phone=document.forms["register"]["phone"].value;
  var pass1=document.forms["register"]["password"].value;
  var pass2=document.forms["register"]["confirmPassword"].value;
  var user=document.forms["register"]["user_name"].value;
  var email=document.forms["register"]["email"].value;



  var split_dob = dob_entry.split("/");
  var month = split_dob[1];
  var day = split_dob[0];
  var year = split_dob[2];
  var dob_asdate = new Date(year, month, day);
  var today = new Date();
  var mili_dif = Math.abs(today.getTime() - dob_asdate.getTime());
  var age = (mili_dif / (1000 * 3600 * 24 * 365.25));
  if(age<18){
    window.alert( "Age Below 18 Years" );
    return false;
  }


  if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email))
  {
    console.log("IN");
      return (true);
    }else{
      alert("You have entered an invalid email address!");
      return (false);
  }


  var phoneno_pattern = /^\d{10}$/;
  if(!phone.match(phoneno_pattern))
  {
    alert("Enter a valid Phone number");
    return false;
  }
  //alert(name);
  if(pass1!==pass2){
    alert("Passwords do not match");
    return false;
  }
  return true;
}
