# Guidelines_netcdf

My guidelines for netCDF files: what kind of attributes / parameters are needed, usual dimension names, etc. The motivation for this repository is that I always end up struggling to find the necessary instructions / list of points to follow to package my netCDF files following CF conventions. Strongly fitted to / following what is recommended by adc.met.no and inspired from the content there.

The main points to follow to be compliant / easy to reuse is to i) use well formed netCDF files, ii) follow metadata conventions. There are different kinds of metadata:

- ACDD (Attribute Conventions Dataset Discovery) is discovery metadata, used to search for datasets / nc files,
- CF (Climate and Forecast metadata conventions) is use metadata, used to understand the content of the files.

Note that netCDF files can be edited (to change dimensions / variables names, attributes names and contents, add / remove any of these) separately from the data they contain using the tooling from netCDF Operator (NCO):

- https://nco.sourceforge.net/ (documentation), https://github.com/nco/nco (code development), among others (see there for more information):
  - ncatted netCDF ATTribute EDitor
  - ncrename netCDF RENAMEer

This makes it easier to edit a file to make it netCDF-CF+ACDD compliant.

## Resources about metadata

#### ACDD metadata

- homepage: https://wiki.esipfed.org/Category:Attribute_Conventions_Dataset_Discovery
  - current release: http://wiki.esipfed.org/index.php/Attribute_Convention_for_Data_Discovery
  - for example, 1-3 attributes: https://wiki.esipfed.org/Attribute_Convention_for_Data_Discovery_1-3

#### CF metadata

- homepage: http://cfconventions.org/index.html
  - latest working draft of the conventions (link on the homepage): http://cfconventions.org/cf-conventions/cf-conventions.html

- list of standard variable names:
  - http://cfconventions.org/Data/cf-standard-names/current/build/cf-standard-name-table.html
  - not sure what the difference is, but another possible source: https://vocab.nerc.ac.uk/standard_name/

- misc
  - files should end in ```.nc```
  - when a variable has a dependence in date or time (T), height or depth (Z), latitude (Y), longitude (X), recommend to order the dimensions as ```(T, Z, Y, X)```
  - if variables provide information about another variable, use ancilliary variable description; see "Ancillary data" in http://cfconventions.org/cf-conventions/cf-conventions.html

## Metadata checkers

Note: on my machine, I have installed all compliance checkers in a conda env:

```
~> eval "$(/home/jrmet/miniconda3/bin/conda shell.bash hook)"
(base) ~> conda activate netcdf_utils
(netcdf_utils) ~> cfchecks -h
 cfchecks [OPTIONS] file1 [file2...]
...
(netcdf_utils) ~> cchecker.py -V
IOOS compliance checker version 5.0.2
(netcdf_utils) ~> ncrename --help
...
(netcdf_utils) ~> ncatted --help
...
```

#### cf-checker

- Run cf-checker (```cfchecks``` command) against the files.

#### compliance-checker

- Run compliance-checker (```cchecker.py``` command) against the files. Note it can be used online at https://compliance.ioos.us/index.html .

## Example and snippets

#### netCDF-CF file templates

See the examples of netCDF-CF file templates at:

- http://cfconventions.org/cf-conventions/cf-conventions.html#appendix-examples-discrete-geometries

#### Attributes **required** by adc.met.no

https://adc.met.no/node/4

#### Dates

Follow the most verbose ISO 8601: "2023-04-20T09:30:32+00:00" for UTC (+00:00) time.

#### Units

Not sure if there is a better source / way to visualize:

- https://docs.unidata.ucar.edu/udunits/current/udunits2-base.xml
- https://docs.unidata.ucar.edu/udunits/current/udunits2-derived.xml
- https://docs.unidata.ucar.edu/udunits/current/udunits2-accepted.xml
- https://docs.unidata.ucar.edu/udunits/current/udunits2-common.xml

#### Expected global attributes for adc.met.no

Typical set of global attributes expected, with examples (gathered from a variety of adc.met.no files)

```
		:boat = "BoatName if relevant" ;
		:title = "A title." ;
		:summary = "A summary." ;
		:keywords = "A list of keywords, will full paths, comma separated, like: GCMDSK: EARTH SCIENCE > ATMOSPHERE > ATMOSPHERIC TEMPERATURE > SURFACE TEMPERATURE > AIR TEMPERATURE, GCMDSK: EARTH SCIENCE > ATMOSPHERE > ATMOSPHERIC WATER VAPOR > WATER VAPOR INDICATORS > HUMIDITY > RELATIVE HUMIDITY" ;
		:keywords_vocabulary = "A list of keyword vocabularies / origins, with full paths, comma separated, like: GCMDSK: GCMD Science Keywords, GCMDLOC: GCMD Locations" ;
		:data_type = "netCDF-4" ;
		:standard_name_vocabulary = "CF Standard Name Table v80" ;
		:geospatial_lat_min = 77.95926 ;
		:geospatial_lat_max = 78.85822 ;
		:geospatial_lon_min = 13.38286 ;
		:geospatial_lon_max = 17.46182 ;
		:area = "Area description, general to specific, comma separated, like: Svalbard, Isfjorden" ;
		:time_coverage_start = "2022-08-30T00:00:00Z" ;
		:time_coverage_end = "2022-08-30T23:50:00Z" ;
		:Conventions = "CF-1.8, ACDD-1.3" ;
		:date_created = "2023-03-22T09:29:32Z" ;
		:featureType = "timeSeries" ;
		:history = "File created at 2023-03-22T09:29:32Z using xarray in Python3." ;
		:processing_level = "Basic quality control" ;
		:creator_type = "person, person, person" ;
		:creator_institution = "The University Centre in Svalbard, The University Centre in Svalbard, Norwegian Meteorological Institute" ;
		:creator_name = "Lukas Frank, Marius Opsanger Jonassen, Teresa Remes" ;
		:creator_email = "lukasf@unis.no, mariusj@unis.no, teresav@met.no" ;
		:creator_url = "https://orcid.org/0000-0003-1472-7967, https://orcid.org/0000-0002-4745-9009, https://orcid.org/0000-0002-6421-859X" ;
		:institution = "The University Centre in Svalbard (UNIS)" ;
		:project = "Isfjorden Weather Information Network (IWIN)" ;
		:source = "Gill MaxiMet GMX 500" ;
		:platform = "WATER-BASED PLATFORMS > VESSELS > SURFACE" ;
		:platform_vocabulary = "GCMD Platform Keywords" ;
		:instrument = "IN SITU/LABORATORY INSTRUMENTS > CURRENT/WIND METERS > SONIC ANEMOMETER, IN SITU/LABORATORY INSTRUMENTS > PRESSURE/HEIGHT METERS > PRESSURE SENSORS, IN SITU/LABORATORY INSTRUMENTS > TEMPERATURE/HUMIDITY SENSORS > TEMPERATURE SENSORS, IN SITU/LABORATORY INSTRUMENTS > TEMPERATURE/HUMIDITY SENSORS > HUMIDITY SENSORS" ;
		:instrument_vocabulary = "GCMD Instrument Keywords" ;
		:license = "https://creativecommons.org/licenses/by/4.0/ (CC-BY-4.0)" ;
		:iso_topic_category = "climatologyMeteorologyAtmosphere" ;
		:operational_status = "Operational" ;
		:activity_type = "In Situ Land-based station" ;
		:principal_investigator = "FirstName LastName" ;
		:publisher_name = "Norwegian Meteorological Institute / Arctic Data Centre" ;
		:publisher_institution = "Norwegian Meteorological Institute / Arctic Data Centre (NO/MET/ADC)" ;
		:publisher_url = "https://adc.met.no/" ;
		:publisher_email = "adc-support@met.no" ;
		:publisher_type = "institution" ;
```
