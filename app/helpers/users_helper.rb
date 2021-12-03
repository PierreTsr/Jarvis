module UsersHelper
  # Calculates distance between two coordinates. Not taken square root here as a greater distance will have this value greater regardless of a square root.
  # Parameters: Two coordinate objects. Coordinate object -> {lat:<Latitude_Value>,lng:<Longitude_Value>}
  def distance_between_coordinates(cd_1, cd_2)
    return Math.sqrt(((cd_1[:lat]-cd_2[:lat])**2) + ((cd_1[:lng]-cd_2[:lng])**2))
  end

  # 
  def relative_distances_for_all_businesses(source_cd, cds)
    distances = []
    cds.each do |cd| 
      d = Geocoder::Calculations.distance_between([source_cd[:lat], source_cd[:lng]], cd)
      # d = distance_between_coordinates(source_cd, {:lat => cd["latitude"].to_f, :lng => cd["latitude"].to_f})
      distances.push(d)
    end
    return distances
  end

  def coordinates_to_miles(coordinates, miles)
    latitude = coordinates[:lat]
    longitude = coordinates[:lng]
    cds = Geocoder::Calculations.bounding_box([latitude, longitude], miles)
    return cds
    # 1 latitude degree ~ 69 miles
    top_latitude = latitude + miles * (1/69.to_f);
    bottom_latitude = latitude - miles* (1/69.to_f);

    # 1 degree of Longitude = cosine (latitude in decimal degrees) * length of degree (miles) at equator
    top_longitude = Math.cos(top_latitude) * 69
    bottom_longitude = Math.cos(bottom_latitude) * 69
    # puts coordinates
    # return [{:lat => top_latitude, :lng => top_longitude}, {:lat => bottom_latitude, :lng => bottom_longitude}]

   end
end
