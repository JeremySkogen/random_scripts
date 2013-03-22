// G4TV Archiving script
// RIP AOTS

var util = require('util'),
    sleep = require('sleep'),
    exec = require('child_process').exec,
    child;

var $ = require('jquery');

var i = 0;
var max = 474;
var url = "http://www.g4tv.com/attackoftheshow/videos/" //?sort=mostrecent&ajax=false&page=";

var all_video_numbers = {};

nextPage();

function fetchPage(i){
    console.log("Fetching page: "+url+i);
  
    var child = exec('curl -d \'ajax=true&page='+i+ "\' " + url,
    function (error, stdout, stderr) {      
      var page = $(stdout);
      var els = $("div a", stdout).each(function(a,b){
        //console.log(b.href);
        var num = b.href.match(/(g4tv\.com\/videos\/[\d]*)+/gi);
        if(num && num[0]){
          num = num[0].split("/");
          if(num[2]){
            all_video_numbers[num[2]+""] = '';
          }
        }
        
      })
      
      sleep.sleep(3);
      nextPage();
  });
}

function nextPage(){
  i++;
  if(i>max){
    //console.log( all_video_numbers );

    var ret_arr = [];
    for(key in all_video_numbers){
      ret_arr.push(key);
    }

    console.log(JSON.stringify(ret_arr));

    return;
  } 
  else fetchPage(i);
}

// http://www.g4tv.com/xml/BroadbandPlayerService.asmx/GetEmbeddedVideo?videoKey=9186&strPlaylist=&playLargeVideo=true&excludedVideoKeys=&playlistType=normal&maxPlaylistSize=10&cb=184943
// http://vids.g4tv.com/videoDB/009/186/video9186/as5081fhmbronstein_G4750_flv.flv