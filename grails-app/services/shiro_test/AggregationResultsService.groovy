package shiro_test

import grails.transaction.Transactional
import resource.DataCenter
import resource.Floor
import resource.Rack
import resource.Host
import resource.PowerStamp
import resource.DataCenters
import java.text.SimpleDateFormat
import java.util.*
import groovy.time.*
import static java.util.Calendar.*
import shiro_test.User
import shiro_test.Cost_Center
import java.lang.Math;
import java.util.Collections.*;
import resource.Scheduler
import shiro_test.Result
import shiro_test.Server
import java.util.concurrent.*;

@Transactional
class AggregationResultsService {

    private static ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    def serviceMethod() {

	DataCenters dcs = new DataCenters();

	String [] arr = new String[1]

	arr[0] = "dc1fl1rk1ht1"

	String results = "";
	ArrayList<Double> allPowerConsumptionEntries = new ArrayList<Double>();
	ArrayList<String> servers = new ArrayList<String>();
	ArrayList<Long> timestamps = new ArrayList<Long>();
	ArrayList<Double> powerratings = new ArrayList<Double>();
	for(DataCenter d: dcs.getDatacenters()){
		for(Floor f: d.getFloors()){
			for(Rack rk: f.getRacks()){
				for(Host h: rk.getHosts()){
					for(Iterator<HashMap<String, HashMap<Long, Double>>> hs = h.getPower(h.getTrackerId()).keySet().iterator(); hs.hasNext() && arr.contains(h.getTrackerId());){
						String key = hs.next();
						HashMap<Long, Double> value = h.getPower(h.getTrackerId()).get(key);
						Map<Long, Double> values = new TreeMap<Long, Double>(value);

						for(Iterator<Long> it = values.keySet().iterator(); it.hasNext();){
							Long innerkey = it.next();
							Double powervalue = values.get(innerkey);
							allPowerConsumptionEntries.add(powervalue/1000)
							//converting watts/min to cents/kilowatts/hour
							powervalue = powervalue/1000
							servers.add(key)
							timestamps.add(innerkey)
							powerratings.add(powervalue)
							results += "key is " + key + " and innerkey is " + innerkey + " and power value is " + powervalue + " "			
						}
					}
				}
			}
		}
	}


	Double totalDailyPower = 0;
	Double totalDailyCarbon = 0;
	Double totalDailyPowerCost = 0;
	Calendar calDateForDailyGraph;
	int daysInMonthForDailyGraph = 0;
	int monthForDailyGraph = 0;
	
	Date yesterday = new Date(System.currentTimeMillis() - 1000L * 60L * 60L * 24L);
	Date newDate;

	for(def i=timestamps.size() - 1; i > 0; i--){
		newDate = new Date((long)timestamps[i]*1000);
		calDateForDailyGraph = dateToCalendar(newDate)
		daysInMonthForDailyGraph = calDateForDailyGraph.getActualMaximum(Calendar.DAY_OF_MONTH)
		monthForDailyGraph = calDateForDailyGraph.get(Calendar.MONTH)
	
		if(newDate > yesterday){
			totalDailyPower += allPowerConsumptionEntries[i]
			
		}
	}
	
	
	//metric taken from www.carbonindependent.org
	totalDailyCarbon = 0.527 * totalDailyPower;

	Server s = new Server(serverName: "Cosby", rack:1, floor:1, location:"Howth");
	s.save()

	Result result1 = new Result(dateOfQuery:newDate, dailyTotalCents: totalDailyPower, metric_2: 3, metric_3: 1, metric_4: 2, servers: s)
	result1.save()
	return result1

    }

    def static Calendar dateToCalendar(Date date){
	Calendar cal = Calendar.getInstance()
	cal.setTime(date)
	return cal
	
    }

  
	

    public void makeScheduledAPICall(){
	final Runnable call = new Runnable(){
		public void run() { 
			Result res = serviceMethod();
			System.out.println("new result id is " + res)
			System.out.println("call!");
		 }
	};


	final ScheduledFuture<?> callHandle = scheduler.scheduleAtFixedRate(call, 0, 5, TimeUnit.SECONDS);
	scheduler.schedule(new Runnable() {
		public void run(){ callHandle.cancel(true); }
	}, 60 * 60, TimeUnit.SECONDS);
    }
    
}