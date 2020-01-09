ALTER AVAILABILITY GROUP DistributedAG  
   JOIN   
   AVAILABILITY GROUP ON  
      'App1' WITH    
      (   
         LISTENER_URL = 'tcp://App1Listener.prosqladmin.com:1433',    
         AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT,   
         FAILOVER_MODE = MANUAL,   
         SEEDING_MODE = AUTOMATIC   
      ),   
      'Linux_AOAG' WITH    
      (   
         LISTENER_URL = 'tcp://LinuxListener:5022',   
         AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT,   
         FAILOVER_MODE = MANUAL,   
         SEEDING_MODE = AUTOMATIC   
      ) ;    
GO   
