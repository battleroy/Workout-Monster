$('#place').typeahead({
    source: function(query, response) {
        console.log('input event');
        var inputVal = $('#place').val();
        $.get("https://geocode-maps.yandex.ru/1.x/?format=json&geocode=" + inputVal, function(data) {
            var geoobjects = data.response.GeoObjectCollection.featureMember;
            dataSource = [];
            $.each(geoobjects, function(i, geoobject) {
                dataSource.push(geoobject.GeoObject.metaDataProperty.GeocoderMetaData.AddressDetails.Country.AddressLine);
            });
            response(dataSource);
        });
    }
});