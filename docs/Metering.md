# using cmdlets for the metering api

ECShell commands implemented for using the Metering api

## Bucket Billing Info 
to get billing information for a specific bucket use `Get-ECSBucketBilling`  

```Powershell
Get-ECSBucketBilling -Namespace ns1 -Bucketname test
```

>namespace       : ns1   
>name            : test    
>sample_time     : 2018-01-29T04:39:52Z    
>vpool_id        : urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global  
>total_size      : 2  
>total_size_unit : GB  
>total_objects   : 5  
>TagSet          :  

## Bucket Billing for a sample interval

you can specify `-start_time` and `-end_time` with `Get-ECSBucketBilling` to get a Sample Interval for billing  

```Powershell 
Get-ECSBucketBilling -Namespace ns1 -Bucketname test -start_time 2018-01-01T00:00 -end_time 2018-01-31T23:55
```

>
namespace         : ns1  
name              : test  
vpool_id          : urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global  
sample_start_time : 2018-01-01T00:00:00Z  
sample_end_time   : 2018-01-31T23:55:00Z  
objects_created   : 5  
objects_deleted   : 0  
bytes_delta       : 1617002503  
total_size        : 2  
total_size_unit   : GB  
total_objects     : 5  
ingress           : 1617002503  
egress            : 0  
TagSet            :  
>

## using different Meaurement Units on Bucket Billing 
teh default unit of mesurement is GB. However, if you are going to meter upon KB or MB, just ass `-sizeunit` to the Commands, ie

```Powershell
Get-ECSBucketBilling -Namespace ns1 -Bucketname test -sizeunit MB


namespace       : ns1  
name            : test  
sample_time     : 2018-01-29T05:04:09Z  
vpool_id        : urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global  
total_size      : 1542  
total_size_unit : MB  
total_objects   : 5  
TagSet          :  
```


```Powershell
Get-ECSBucketBilling -Namespace ns1 -Bucketname test -start_time 2018-01-01T00:00 -end_time 2018-01-31T23:55 -sizeunit KB


namespace         : ns1
name              : test
vpool_id          : urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global
sample_start_time : 2018-01-01T00:00:00Z
sample_end_time   : 2018-01-31T23:55:00Z
objects_created   : 5
objects_deleted   : 0
bytes_delta       : 1617002503
total_size        : 1579104
total_size_unit   : KB
total_objects     : 5
ingress           : 1617002503
egress            : 0
TagSet            :
```

###Examples

**Pipelining** 
```Powershell
Get-ECSBuckets -Namespace ns1 | Get-ECSBucketBilling -sizeunit KB | ft -AutoSize

namespace name    sample_time          vpool_id                                                                       total_size total_size_unit total_objects TagSet
--------- ----    -----------          --------                                                                       ---------- --------------- ------------- ------
ns1       bucket1 2018-01-29T05:11:34Z urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global 439876     KB              130
ns1       bucket2 2018-01-29T05:11:35Z urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global 124723     KB              41
ns1       bucket3 2018-01-29T05:11:35Z urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global 0          KB              0
ns1       bucket4 2018-01-29T05:11:36Z urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global 0          KB              0
ns1       test    2018-01-29T05:11:36Z urn:storageos:ReplicationGroupInfo:a4ebded4-ce6f-4918-8756-101df81caa5b:global 1579104    KB              5
```

**Advanced formatting**
```Powershell
Get-ECSBuckets -Namespace ns1 |  Get-ECSBucketBilling -start_time 2018-01-01T00:00 -end_time 2018-01-31T23:55 -sizeunit MB | where total_objects -ne 0 | select * -ExcludeProperty vpool_id | ft

namespace name    sample_start_time    sample_end_time      objects_created objects_deleted bytes_delta total_size total_size_unit total_objects
--------- ----    -----------------    ---------------      --------------- --------------- ----------- ---------- --------------- -------------
ns1       bucket1 2018-01-01T00:00:00Z 2018-01-31T23:55:00Z 130             0               450433129   430        MB              130
ns1       bucket2 2018-01-01T00:00:00Z 2018-01-31T23:55:00Z 41              0               127716258   122        MB              41
ns1       test    2018-01-01T00:00:00Z 2018-01-31T23:55:00Z 5               0               1617002503  1542       MB              5

```
