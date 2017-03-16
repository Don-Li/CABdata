#### vi_1 dataset

#' vi_1 dataset
#'
#' Data from a single variable-interval experiment.
#'
#' This experiment was run using MED-PC and in-line Pascal procedures were used to arrange the reinforcement delvieries. The random number generation in Pascal requires setting a seed. The way that Pascal sets seeds is that the seed is based on the time at which the set seed function was called. As a result, subjects that started their experiments at the same time had the first reinforcement arranged at the same time. The set seed function is called each time a random number is requested, so the subsequent reinforcements are arranged at different times due to the variability in the organisms' responding.
#'
#' @section{ Subjects }:{
#'     11 pigeons with subject labels: 221, 222, 223, 224, 225, S01, S02, S03, S04, S05, S06.
#'
#'     Because of injury, S01 was removed from the study.
#' }
#'
#' @section{ VI schedule }:{
#'     A reinforcement delivery is arranged by sampling inter-reinforcement intervals from an Exponential distribution. The arranged inter-reinforcement intervals were: 30s, 60s, and 240s. See the \code{Experiment} and \code{VI} columns.
#' }
#'
#' @section{ Reinforcement delivery }:{
#'     Reinforcement deliveries were 2s access to wheat.
#' }
#'
#' @section{ Response recording }:{
#'     Responses with inter-response times shorter than 0.1s were recorded (exclusive). Responses that occurred faster than 0.1s after the preceeding response were not recorded.
#' }
#'
#' @section{ Session duration }:{
#'     Sessions lasted 1800s.
#' }
#'
#' @section{ Additional notes }:{
#'     A bug occurred with MED-PC, where a reinforcement delivery that overlapped with the end of the session caused a response to be recorded at the end of the session. For example, if reinforcement was delivered at 1799 seconds, the reinforcement delivery would have extended to 1801 seconds. This resulted in a response to be recorded at 1800 seconds. These responses have been removed from the event records. But the \code{resp} counter in the \code{resp} column still has this extra response in it. Hence, calculating molar rates from the \code{resp} column will be incorrect without correcting for this.
#'
#'     We had a problem with the hardwhare where the response keys would "bounce" after some responses with a particular response topography. This resulted in more than one response being recorded for some key pecks. An attempt to remedy the key bounding was to only record responses with inter-response times longer than or equal to 0.1s. However, the duration of the bouncing was on the order of 0.1s. Therefore, in some cases, the key bounces are recorded. This is evident when examining the inter-response time distributions. For many subjects, there is a group of inter-response times around 0.1s to 0.15s that are separate from all of the other inter-response times. In some cases, pigeons may "nibble" on the key resulting in some legitimate response times around this 0.1s to 0.15s band; in these cases, it is difficult to tell which responses are "nibbles" and which are keybounces. See examples.
#' }
#'
#' @docType data
#'
#' @usage data(vi_1)
#'
#' @format A \code{data.table}.
#'
#' @keywords variable_interval
#'
#' @examples
#' #### Code for reading the raw files and producing the data file ####
#'
#' file_path = "I:/Data" variable_arrays = list( C = c("resp","rft") )
#' event_arrays = list( X = c("resp_time" = 1, "rft_time" = 2, "start" = 9 ) )
#' general_arrays = list( J = "arranged_vi" ) vi_1 =
#' import_medpc_to_formal_event_record( "Backup", variable_arrays, event_arrays,
#' general_arrays, file_path = file_path, round = 2 )
#'
#' #Fix some bad labels vi_1[ Experiment == "vi_30240", Experiment := "vi_240" ]
#' vi_1[ MSN == "new_don_vi_60", Experiment := "vi_60" ] #Take out subject 226
#' and S01 vi_1 = vi_1[ (Subject != 226 & Subject != "S01"), ]
#'
#' #Fix column names setnames( vi_1, c("Start Date","End Date" ), c(
#' "Start_Date", "End_Date" ) ) #Fix the dates vi_1[ , Start_Date := as.Date(
#' Start_Date, format = "%m/%d/%y" ) ] vi_1[ , End_Date := as.Date( End_Date,
#' format = "%m/%d/%y" ) ]
#'
#' #Add numerical values for the VI switch_keys = list( vi_30 = 30, vi_60 = 60,
#' vi_240 = 240 ) switch_fx = function( value, switch_keys ){ switch_keys = c(
#' list( EXPR = value ), switch_keys ) do.call( switch, switch_keys ) } vi_1[ ,
#' VI :=  vapply( Experiment, function(x) switch_fx( x, switch_keys ), FUN.VALUE
# = 1 ) ]
#'
#' #Order by subjects, date setorder( vi_1, Subject, Start_Date )
#'
#' #Add number for vi sessions vi_1[ , VI_session := rep(1:20) ]
#'
#' #Save the data save( vi_1, file = "vi_1.RData")
#'
#' ### Showing small inter-response times and bouncing keys ####
#' library( CAB )
#' working_data = copy( vi_1 )
#' working_data[ ,
#'    c( "resp_rate", "rft_rate") := transpose( lapply( event_record,
#'        function(x){
#'            compute.session_rates(
#'                data = x,
#'                event_offsets = list( rft_time = -2 ),
#'                dims = c("resp_time", "rft_time"),
#'                session_duration = 1800
#'            )
#'        } ) )
#' ]
#'
#' irts = working_data[ , unlist( irt, use.names = F ), by = Subject ]
#' # Subject 221 irts
#' hist( irts[ Subject == 221, V1 ], breaks = 10000 ] )
#' # Subject 221 small irts
#' # Note the small group around 0.1s. These are from the bouncing keys.
#' hist( irts[ Subject == 221, V1 ], breaks = 100000 ], xlim = c(0, 1) )
#'
#' #Subject 224 irts
#' hist( irts[ Subject == 224, V1 ], breaks = 10000 ] )
#' # Subject 224 small irts
#' # Note the large group smaller than 0.2s. These are from a combination of "nibbling" responses and bouncing keys.
#' hist( irts[ Subject == 224, V1 ], breaks = 100000 ], xlim = c(0, 1) )


