$(document).ready(function() {
  var availableTags=[];
        $.ajax({
          url: '../colleagues/autocomplete',
          error: function (XMLHttpRequest,textStatus,errorThrown) {
          alert("Something went wrong!! Please try again later. Unable to load colleagues list");

      },
      success: function(data){
      jQuery("#search_user").html("This Person is based in " +data);
      var jsonObj = $.parseJSON(data);
      $.each(jsonObj,function(index,value){
      availableTags.push(value.name);
   

  });


    },
    type: "get"
  });  
$( "#name" ).autocomplete({
  source: function( request, response ) {
    var matches = $.map( availableTags, function(tag) {
      if ( tag.toUpperCase().indexOf(request.term.toUpperCase()) === 0 ) {
        return tag;
      }
    });
    response(matches);
  }
});

//$( "#name" ).autocomplete({
//source: availableTags
//});
 });
   
  var infowindow = null;

  function initialize() { 
   $.ajax({
    url: '../colleagues/allpins',
    error: function (XMLHttpRequest,textStatus,errorThrown) {
      alert("Something went wrong!! Please try again later. Unable to load map");

    },
    success: function(data){

      initializePage(data); 

    },
    type: "get"
  });  

 }

  $(document).ready(initialize);
  var address ;
  

  function center()
  {

    name=document.getElementById("name").value;
    
    $.ajax({
      url: '../colleagues/search?search='+name,
      error: function (XMLHttpRequest, textStatus, errorThrown) {
        alert("Something went wrong!! Please try again later.");

      },
      success: function(data){

    
          var jsonObj = $.parseJSON(data);



            $.each(jsonObj,function(index,value){
 
    address=value.place;
    image=value.image;

    
  });
    
   
       
       jQuery("#search_user").html("This Person is based in " +address);
  
       initializeSearch(name,address,image);
     },
     type: "get"
   });  
  }
  function initializePage(data) {

    var centerMap = new google.maps.LatLng(0,0);

    var myOptions = {
      zoom: 2,
      center: centerMap,
      minZoom: 2, 
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    var sites = createAllSites(data);
    setMarkers(map, sites);
        /*infowindow = new google.maps.InfoWindow({
                content: "loading..."
              });*/
} 

function createAllSites(data){
  var sites=[];

  var jsonObj = $.parseJSON(data);

  $.each(jsonObj,function(index,value){
    var site=[];
    site.push(value.place);
    site.push(parseFloat(value.longitude));
    site.push(parseFloat(value.latitude));
    site.push(2);


    site.push("<div style='text-align:center'><b> Number of employees in "+ value.place+"="+value.count+"<br/>"+value.place+"<br/><a href='../colleagues/list?loc="+ value.place+"' target='_blank'>View full List</a></div>");
    sites.push(site);
  });
  return sites;
}

function initializeSearch(name,address,image) {


  var centerMap = new google.maps.LatLng(0,0);

  var myOptions = {
    zoom: 4,
    center: centerMap,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

  var bikeLayer = new google.maps.BicyclingLayer();
  bikeLayer.setMap(map);

  geocoder = new google.maps.Geocoder();

  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
        //In this case it creates a marker, but you can get the lat and lng from the location.LatLng
      
        map.setCenter(results[0].geometry.location);
        var sites = createSites(results[0].geometry,address,name,image);
        setSearchMarkers(map, sites);
        /*infowindow = new google.maps.InfoWindow({
                content: "loading..."
              });*/
}
} );

}

function createSites(geometry,address,name){


 var sites = [
 [address, geometry.location.lat(), geometry.location.lng(), 2,"<div style='text-align:center'><b> User Name : "+name+"<br/>Based in :"+address+""+"<br/><br/><img src='"+image+"'>"]
 ];

 return sites;
}

var addressField = document.getElementById('search_address');
var geocoder = new google.maps.Geocoder();





function setMarkers(map, sites) {

  for (var i = 0; i < sites.length; i++) {
    var site = sites[i];
  
    var siteLatLng = new google.maps.LatLng(site[1], site[2]);

    var marker = new google.maps.Marker({
      position: siteLatLng,

      map: map,

      title: site[0],
      zIndex: site[3],
      html: site[4]
    });

    google.maps.event.addListener(marker, "click", function () {

     infowindow = new google.maps.InfoWindow({
      content: "loading..."
    });
     infowindow.setContent(this.html);
     infowindow.open(map, this);

     map.setCenter(this.getPosition());
   });

  }
}
function setSearchMarkers(map, sites) {


  for (var i = 0; i < sites.length; i++) {
    var site = sites[i];
  
    var siteLatLng = new google.maps.LatLng(site[1], site[2]);

    var marker = new google.maps.Marker({
      position: siteLatLng,

      map: map,

      title: site[0],
      zIndex: site[3],
      html: site[4]
    });

    google.maps.event.addListener(marker, "click", function () {

     infowindow = new google.maps.InfoWindow({
      content: "loading..."
    });
     infowindow.setContent(this.html);
     infowindow.open(map, this);

     map.setCenter(this.getPosition());
   });




    infowindow = new google.maps.InfoWindow({
      content: site[4]
    });
    infowindow.open(map, marker);
  } 
    google.maps.event.addListener(infowindow, 'closeclick', function() {  

    initialize(); 
})


}