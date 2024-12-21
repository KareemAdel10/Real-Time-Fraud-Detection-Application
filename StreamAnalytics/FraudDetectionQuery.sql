WITH Calls AS (
    SELECT
        recordType,
        systemIdentity,
        switchNum,
        callingNum,
        calledNum,
        callPeriod,
        COUNT(*) OVER (PARTITION BY callingNum LIMIT DURATION (hour, 24)) AS CallFrequency,
        AVG(callPeriod) OVER (PARTITION BY callingNum LIMIT DURATION (hour, 24)) AS AvgCallDuration
    FROM
        [myfirsteventhub]
)

SELECT
    *,
    CASE 
        WHEN CallFrequency > 10 THEN 'Fraudulent:-High-Call-Frequency'
        WHEN callPeriod > 1800 THEN 'Fraudulent:-Unusually-Long-Call'
        WHEN switchNum IN ('India', 'Brazil') THEN 'Fraudulent:-Uncommon-Switch-Location'
        ELSE 'Legitimate'
    END AS FraudDetectionReason
INTO
    [FraudulentCalls]
FROM
    Calls

