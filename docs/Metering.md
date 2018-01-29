# using cmdlets from the metering api

ECShell aht some commands implemented for the Metering api

## Bucket Billing Info 
to get billing information for a specific bucket use `Get-ECSBucketBilling´

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

