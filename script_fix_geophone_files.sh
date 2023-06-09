
# to run on a single file, just set filename (used now, need to update the name and set the lat and lon by hand anyways so cannot loop automatically)
FILENAME="Geophone1_Tempelfjorden_February_2022.nc"

# to run on all files, loop
# for FILENAME in Geophone*_Tempelfjorden_February_2022.nc; do

    # new files without the buggy lat and lon used so far
    ncks -O -x -v dummy,latitude,longitude $FILENAME ${FILENAME}_out.nc
    FILENAME=${FILENAME}_out.nc

    echo "Fix CF and ACDD metadata for $FILENAME"

    ## global attributes

    # clear all global attributes
    ncatted --history -a .*,global,d,c,, "$FILENAME"

    # fill in the adc.met.no required attributes
    ncatted --history -a title,global,c,c,'Geophone deployment in Svalbard 2022' "$FILENAME"
    ncatted --history -a summary,global,c,c,'Geophone deployment in Svalbard 2022, to measure the vibrations in sea ice following the appearance of cracks. For more information, see https://github.com/jvoermans/Geophone_Logger .' "$FILENAME"
    ncatted --history -a keywords,global,c,c,'GCMDSK: EARTH SCIENCE > CRYOSPHERE > SEA ICE, GCMDSK: EARTH SCIENCE > CRYOSPHERE > SEA ICE > SEA ICE MOTION, GCMDLOC: OCEAN > ATLANTIC OCEAN > NORTH ATLANTIC OCEAN > SVALBARD AND JAN MAYEN' "$FILENAME"
    ncatted --history -a keywords_vocabulary,global,c,c,'GCMDSK: GCMD Science Keywords, GCMDLOC: GCMD Locations' "$FILENAME"
    ncatted --history -a geospatial_lat_min,global,c,c,'78.3' "$FILENAME"
    ncatted --history -a geospatial_lat_max,global,c,c,'78.5' "$FILENAME"
    ncatted --history -a geospatial_lon_min,global,c,c,'17.2' "$FILENAME"
    ncatted --history -a geospatial_lon_max,global,c,c,'17.4' "$FILENAME"
    ncatted --history -a time_coverage_start,global,c,c,'2022-02-11T00:00:00+00:00' "$FILENAME"
    ncatted --history -a time_coverage_end,global,c,c,'2022-02-28T23:00:00+00:00' "$FILENAME"
    ncatted --history -a Conventions,global,c,c,'CF-1.8, ACDD-1.3' "$FILENAME"
    ncatted --history -a source,global,c,c,"Hydrophone measurements with custom instrument" "$FILENAME"
    ncatted --history -a date_created,global,c,c,"2023-04-20T12:00:00+00:00" "$FILENAME"
    ncatted --history -a creator_type,global,c,c,"person, person" "$FILENAME"
    ncatted --history -a creator_institution,global,c,c,"The University of Melbourne, Norwegian Meteorological Institute" "$FILENAME"
    ncatted --history -a creator_name,global,c,c,"Joey Voermans, Jean Rabault" "$FILENAME"
    ncatted --history -a creator_email,global,c,c,"jvoermans@unimelb.edu.au, jean.rblt@gmail.com" "$FILENAME"
    ncatted --history -a creator_url,global,c,c,"https://scholar.google.nl/citations?user=oMkqq6YAAAAJ&hl=nl, https://scholar.google.fr/citations?user=RWVXUdYAAAAJ&hl=fr" "$FILENAME"
    ncatted --history -a project,global,c,c,"ONR N62909-20-1-2080, Australian Antarctic Program 4593, RCN Svalbard Strategic Grant 311266 MISIB" "$FILENAME"
    ncatted --history -a instrument,global,c,c,"Geophone custom developed" "$FILENAME"
    ncatted --history -a references,global,c,c,"https://github.com/jvoermans/Geophone_Logger" "$FILENAME"
    ncatted --history -a license,global,c,c,"https://creativecommons.org/licenses/by/4.0/ (CC-BY-4.0)" "$FILENAME"
    ncatted --history -a operational_status,global,c,c,"Scientific" "$FILENAME"
    ncatted --history -a activity_type,global,c,c,"In Situ Ice-based station" "$FILENAME"
    ncatted --history -a iso_topic_category,global,c,c,"oceans" "$FILENAME"
    ncatted --history -a featureType,global,c,c,"timeSeries" "$FILENAME"
    ncatted --history -a standard_name_vocabulary,global,c,c,"CF Standard Name Table v80" "$FILENAME"
    ncatted --history -a processing_level,global,c,c,"Basic quality control" "$FILENAME"

    ## dimension editing
    ncrename --history -d sample,obs "$FILENAME"

    ## variables attributes

    # add the standard attributes to the variables
    for CRRT_VAR in X Y Z1 Z2 Z3; do
        ncatted --history -a standard_name,$CRRT_VAR,c,c,"discretized geophone signal" "$FILENAME"
        ncatted --history -a long_name,$CRRT_VAR,c,c,"discretized geophone signal" "$FILENAME"
        ncatted --history -a units,$CRRT_VAR,c,c,"1" "$FILENAME"
        ncatted --history -a coverage_content_type,$CRRT_VAR,c,c,"physicalMeasurement" "$FILENAME"
    done

    ncatted --history -a standard_name,time,c,c,"time" "$FILENAME"
    ncatted --history -a long_name,time,c,c,"time of measurement" "$FILENAME"
    ncatted --history -a units,time,c,c,"nanoseconds since 1970-01-01T00:00:00+00:00" "$FILENAME"

    # add dimensions: lat and lon, length 1
    ncap2 --history --append -s 'defdim("lat",1)' "$FILENAME"
    ncap2 --history --append -s 'defdim("lon",1)' "$FILENAME"

    # add variables: lat and lon are double arrays, (start, step, $dim) with $dim=1 is a single value
    ncap2 --history --append -s 'lat=array(78.433232703800542,0,$lat)' "$FILENAME"
    ncap2 --history --append -s 'lon=array(17.302795181317087,0,$lon)' "$FILENAME"

    ## add the attributes for lat and lon
    ncatted --history -a standard_name,lat,c,c,"latitude" "$FILENAME"
    ncatted --history -a long_name,lat,c,c,"station latitude" "$FILENAME"
    ncatted --history -a units,lat,c,c,"degrees_north" "$FILENAME"
    ncatted --history -a standard_name,lon,c,c,"longitude" "$FILENAME"
    ncatted --history -a long_name,lon,c,c,"station longitude" "$FILENAME"
    ncatted --history -a units,lon,c,c,"degrees_east" "$FILENAME"

    ## avoid cluttered history
    ncatted --history -a history,global,o,c,"created 2023-03 by Joey Voermans, attributes edited 2023-04 by Jean Rabault" "$FILENAME"

    ## check metadata
    ncdump -h "$FILENAME"

    ## check content of new variables
    # ncdump -v lat "$FILENAME"
    # ncdump -v lon "$FILENAME"
    ncdump -v lat,lon "$FILENAME"

# done
