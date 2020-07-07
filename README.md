#####Simple log parser which takes excel file containing columns
|timestamp	|	url			|	method	|	response_time	|	response_code	|
|-----------|:-------------:|:---------:|:-----------------:|------------------:|
|1581333404	|	/person/all	|	GET		|		124			|		200			|
|1581333441	|	/person/add |	POST	|		283			|		201			|



##Below command to generate two excel automatically from default SampleLog.csv file

```ruby -r "~/Downloads/api_log/parser/caller.rb" -e "Caller.perform_log_parsing_operations"```


#for different file name use below 

```LogParser::Client.new({file_path: "YourFileName.csv"}).maximum_called_api```

```LogParser::Client.new({file_path: "YourFileName.csv"}).response_times```

