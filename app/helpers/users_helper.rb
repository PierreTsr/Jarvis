module UsersHelper
  # Calculates distance between two coordinates. Not taken square root here as a greater distance will have this value greater regardless of a square root.
  # Parameters: Two coordinate objects. Coordinate object -> {lat:<Latitude_Value>,lng:<Longitude_Value>}
  def distance_between_coordinates(cd_1, cd_2)
    return Math.sqrt(((cd_1[:lat]-cd_2[:lat])**2) + ((cd_1[:lng]-cd_2[:lng])**2))
  end

  # 
  def relative_distances_for_all_businesses(source_cd, cds)
    cds = cds.as_json
    distances = []
    cds.each do |cd| 
      d = distance_between_coordinates(source_cd, {:lat => cd["latitude"].to_f, :lng => cd["latitude"].to_f})
      distances.push(d)
    end
    return distances
  end
end
