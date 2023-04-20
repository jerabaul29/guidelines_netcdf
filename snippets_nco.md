# Snippets from the nco toolkit

## add global attribute

```
(netcdf_utils) ~/Downloads> ncdump -h Hydrophone_Tempelfjorden_February_2022_file1851_1900.nc 
netcdf Hydrophone_Tempelfjorden_February_2022_file1851_1900 {
dimensions:
	sample = UNLIMITED ; // (662400000 currently)
variables:
	short audio(sample) ;
	int64 time(sample) ;
}
(netcdf_utils) ~/Downloads> ncatted -a test,global,c,c,'hello test' Hydrophone_Tempelfjorden_February_2022_file1851_1900.nc 
(netcdf_utils) ~/Downloads> ncdump -h Hydrophone_Tempelfjorden_February_2022_file1851_1900.nc 
netcdf Hydrophone_Tempelfjorden_February_2022_file1851_1900 {
dimensions:
	sample = UNLIMITED ; // (662400000 currently)
variables:
	short audio(sample) ;
	int64 time(sample) ;

// global attributes:
		:test = "hello test" ;
}
```
