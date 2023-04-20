
# to run on a single file, just set filename (not used now)
# FILENAME="Hydrophone_Tempelfjorden_February_2022_file1851_1900.nc"

# to run on all files, loop
for FILENAME in Hydrophone_Tempelfjorden_February_2022_file*_*.nc; do

    echo "Fix CF and ACDD metadata for $FILENAME"

    ## global attributes

    # clear all global attributes
    ncatted --history -a .*,global,d,c,, "$FILENAME"

    # fill in the adc.met.no required attributes
    ncatted --history -a title,global,c,c,'Hydrophone deployment in Svalbard 2022' "$FILENAME"
    ncatted --history -a summary,global,c,c,'Hydrophone deployment in Svalbard 2022, to measure the vibrations in sea ice following the appearance of cracks. For more information, see https://github.com/jvoermans/Geophone_Logger .' "$FILENAME"
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
    ncatted --history -a instrument,global,c,c,"Hydrophone custom developed" "$FILENAME"
    ncatted --history -a references,global,c,c,"https://github.com/jvoermans/Geophone_Logger" "$FILENAME"
    ncatted --history -a license,global,c,c,"https://creativecommons.org/licenses/by/4.0/ (CC-BY-4.0)" "$FILENAME"
    ncatted --history -a operational_status,global,c,c,"Scientific" "$FILENAME"
    ncatted --history -a activity_type,global,c,c,"In Situ Ice-based station" "$FILENAME"
    ncatted --history -a iso_topic_category,global,c,c,"oceans" "$FILENAME"
    ncatted --history -a featureType,global,c,c,"timeSeries" "$FILENAME"
    ncatted --history -a latitude_deployment,global,c,c,"XXTODO" "$FILENAME"
    ncatted --history -a longitude_deployment,global,c,c,"XXTODO" "$FILENAME"
    ncatted --history -a standard_name_vocabulary,global,c,c,"CF Standard Name Table v80" "$FILENAME"
    ncatted --history -a processing_level,global,c,c,"Basic quality control" "$FILENAME"

    ## dimension editing
    ncrename --history -d sample,obs "$FILENAME"

    ## variables attributes

    # remove the test attribute I had added
    # ncatted --history -a test,audio,d,, "$FILENAME"

    # add the standard attributes
    ncatted --history -a standard_name,audio,c,c,"discretized audio signal" "$FILENAME"
    ncatted --history -a long_name,audio,c,c,"discretized audio signal" "$FILENAME"
    ncatted --history -a units,audio,c,c,"1" "$FILENAME"
    ncatted --history -a coverage_content_type,audio,c,c,"physicalMeasurement" "$FILENAME"
    ncatted --history -a standard_name,time,c,c,"time" "$FILENAME"
    ncatted --history -a long_name,time,c,c,"time of measurement" "$FILENAME"
    ncatted --history -a units,time,c,c,"nanoseconds since 1970-01-01T00:00:00+00:00" "$FILENAME"

    ## avoid cluttered history
    ncatted --history -a history,global,o,c,"created 2023-03 by Joey Voermans; attributes edited 2023-04 by Jean Rabault" "$FILENAME"

    ## add missing lat lon dimensions and variables

    # add dimensions
    ncap2 --history --append -s 'defdim("lat",1)' "$FILENAME"
    ncap2 --history --append -s 'defdim("lon",1)' "$FILENAME"

    # add variables
    ncap2 --history --append -s 'lat=array(78.4,0,$lat)' "$FILENAME"
    ncap2 --history --append -s 'lon=array(17.3,0,$lon)' "$FILENAME"

    # add the metadata and fill
    TODO

    ## check metadata
    ncdump -h "$FILENAME"

    ## check content of new variables
    # ncdump -v lat "$FILENAME"
    # ncdump -v lon "$FILENAME"
    ncdump -v lat,lon "$FILENAME"

done
