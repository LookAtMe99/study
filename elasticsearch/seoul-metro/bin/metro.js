var fs = require('fs');

var parse = require('csv-parse');
//var s_meta = require('./station_meta');

//var sInfo = fs.readFileSync('source/station_info.json', 'utf8');
//var sLocation = JSON.parse(sInfo).DATA;
//console.log(sLocation.DATA.length);

var f1to4 = fs.readFileSync('source/2016.csv', 'utf8');
parse(f1to4, {comment:"#"}, function(csv_err, csv_data){
  if (csv_err) {
    return console.log(csv_err);
  }
  //console.log(csv_data.length);
  // console.log("%j",csv_data[0]);
  // console.log("%j",csv_data[1]);
  // console.log("%j",csv_data[2]);
  //호선명,역명,일자,승하차구분,합계,05-06시,06-07시,07-08시,08-09시,09-10시,10-11시,11-12시,12-13시,13-14시,14-15시,15-16시,16-17시,17-18시,18-19시,19-20시,20-21시,21-22시,22-23시,23-24시,24시이후
  //LINE_NM,STAT_NM,INCOME_DATE,ON_OFF_SE,TIME_SM,TIME_05,TIME_06,TIME_07,TIME_08,TIME_09,TIME_10,TIME_11,TIME_12,TIME_13,TIME_14,TIME_15,TIME_16,TIME_17,TIME_18,TIME_19,TIME_20,TIME_21,TIME_22,TIME_23,TIME_24
  //5호선,강동,20141231,승차,22725,329,764,2585,3262,1513,1043,943,1072,1029,1035,1086,1191,1755,1717,1146,811,635,499,202,108
  //5호선,강동,20141231,하차,18367,34,532,714,1468,798,610,612,617,784,788,950,1171,1388,1902,1655,1135,959,959,612,679


  for(var cd=1; cd< csv_data.length ; cd+=2){
    var dataIn = csv_data[cd];
    var dataOut = csv_data[cd+1];

    if(dataIn[0]===dataOut[0] && dataIn[1]===dataOut[1] && dataIn[2]===dataOut[2]){

      //console.log(lStationName);
//        var station_num = "";
//      var station_name = "";
/*
      var ldateTemp = new Array(3);
          ldateTemp[0] = dataIn[2].substr(0,4);
      ldateTemp[1] = dataIn[2].substr(4,2);
      ldateTemp[2] = dataIn[2].substr(6,2);*/
      // console.log(Number(ldateTemp[0]));
      // console.log(Number(ldateTemp[1]));
      // console.log(Number(ldateTemp[2]));
      var ldateTemp = dataIn[0].split('-');
      for(var h=0; h < 20; h++){
/*        var ldate = new Date(ldateTemp[0],Number(ldateTemp[1])-1,ldateTemp[2],h+5);

        // console.log("%j"+ldate);
        // - 로 되어 있는 값들 0으로 변경.
        var people_in = dataIn[5+h];
        //console.log(people_in);
        people_in = Number(people_in);

        var people_out = dataOut[5+h];
        //console.log(people_out);
        people_out = Number(people_out);*/
        var ldate = new Date(ldateTemp[0],Number(ldateTemp[1])-1,ldateTemp[2],h);
        // console.log(ldate.toString());

    //     // - 로 되어 있는 값들 0으로 변경.
        var people_in = dataIn[5+h];
        people_in = people_in.trim();
        if(people_in === "-"){ people_in = "0"; }
        people_in = people_in.replace(/,/g,"");
    //     //console.log(people_in);
        people_in = Number(people_in);

        var people_out = dataOut[5+h];
        people_out = people_out.trim();
        if(people_out === "-"){ people_out = "0"; }
        people_out = people_out.replace(/,/g,"");
    //     //console.log(people_out);
        people_out = Number(people_out);

        //console.log("==== "+station_name);
        var s_logs = {
          "time_slot" : ldate,
          "station_num" : dataIn[1],
          "station_name" : dataIn[2],
          "people_in" : people_in,
          "people_out" : people_out
        }

        //console.log("%j",s_logs);
        //console.log(ldate.toISOString().slice(0,10).replace(/-/g,""));
        var fileName = dataIn[0]+"-"+dataIn[1]+"-"+dataIn[2]+".log";
        //var fileName = "1to4_"+ldate.toISOString().slice(0,10).replace(/-/g,"")+".log";
        var logdata = JSON.stringify(s_logs)+"\n";
        fs.appendFileSync("data/"+fileName, logdata);
      }

    }

  }

});
