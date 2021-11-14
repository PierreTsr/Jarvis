module UsersHelper
  # Calculates distance between two coordinates. Not taken square root here as a greater distance will have this value greater regardless of a square root.
  # Parameters: Two coordinate objects. Coordinate object -> {lat:<Latitude_Value>,lng:<Longitude_Value>}
  def distance_between_coordinates(cd_1, cd_2)
    return (cd_1['lat']-cd_2['lat'])**2 + (cd_1['lng']-cd_2['lng'])
  end

  # Get closest coordinates from a list of coordinates
  def find_closest_coordinates(source_cd, cds)
    min = cds[0]
    cds.each do |cd| 
      if(distance_between_coordinates(source_cd, cd) < min)
         min = cd
      end
    end
    return min
  end
end
