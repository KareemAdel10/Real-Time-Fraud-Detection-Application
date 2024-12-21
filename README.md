# Real-Time-Fraud-Detection-Application

## Overview
This repository contains the implementation of a real-time fraud detection application using Azure services. The solution processes mobile phone call metadata in real-time to identify fraudulent calls based on predefined criteria. The architecture leverages Azure Event Hubs, Azure Stream Analytics, and Azure Blob Storage for a robust and scalable solution.

## Dataflow
1. Mobile phone call metadata: Source system sends call data.
2. Azure Event Hubs: Ingests and streams the data.
3. Azure Stream Analytics: Processes and analyzes the data in real-time.
4. Azure Blob Storage: Stores the processed data in dynamic partitions.
![image](https://github.com/user-attachments/assets/bc8cb1e6-e1b5-48dd-9a5c-e6259c0c2af8)


## Architecture Components
### 1. Azure Event Hubs
  1. **Instance Tier**: Standard.
  2. **Purpose**: Ingest real-time call metadata.
  3. **Dummy Data**: Generated using the Data Explorer feature with the following JSON structure:

    ```
        {
          "recordType": "MO",
          "systemIdentity": "d0",
          "fileNum": "327",
          "switchNum": "Australia",
          "callingNum": 670595273,
          "callingIMSI": "466921602343040",
          "calledNum": "789061013",
          "calledIMSI": "466921302209862",
          "dateS": "20230510",
          "timeS": null,
          "timeType": 0,
          "callPeriod": 191,
          "callingCellID": null,
          "calledCellID": null,
          "serviceType": "b",
          "transfer": 0,
          "incomingTrunk": null,
          "outgoingTrunk": "411",
          "mSRN": "1412983121877",
          "calledNum2": null,
          "fCIFlag": null,
          "callrecTime": "2023-05-10T19:52:09.0000000Z",
          "eventProcessedUtcTime": "2023-05-10T19:56:04.6854726Z",
          "partitionId": 0,
          "eventEnqueuedUtcTime": "2023-05-10T19:52:07.7500000Z"
        }
     ```
### 2. Azure Stream Analytics Job
  1. **Inputs**: Events from Azure Event Hub.
  2. **Queries**:
       - Pass-through Scenario:
          - Events are stored in Azure Data Lake Storage Gen2 without transformation.
       - Fraud Detection Scenario:
          - Predefined query checks for fraudulent calls using the following criteria:
            - High call frequency.
            - Unusually long call duration.
            - Calls from uncommon switch locations.
  3. **Outputs**:
      - There are 2 Defined Output paths:
        1. **Pass-through**: `streaming-data/PassThroughOutput/{switchNum}`.
           ![image](https://github.com/user-attachments/assets/c52308a5-6084-46be-97b9-4b7bea8dbae0)

        3. **Fraud Detection**: `streaming-data/FraudulentCalls/{FraudDetectionReason}`.
           ![image](https://github.com/user-attachments/assets/0ff8b9c3-8901-42f0-99f0-9967d2a0d7e4)
## Key Features
- Real-time Processing: Leveraging Azure Stream Analytics for low-latency data processing.
- Dynamic Partitioning: Data is stored in Azure Blob Storage based on switch location or fraud detection reason.
- Scalability: Built on Azure Event Hubs and Stream Analytics for scalable data ingestion and processing.

## Setup Instructions:
1. Clone this repository.
2. Configure an Azure Event Hub instance.
3. Create an Azure Stream Analytics job with the provided queries.
4. Set up Azure Blob Storage as the output sink.
5. Run the Stream Analytics job and monitor the output in Blob Storage.

## Acknowledgments
Special thanks to the Azure documentation and tutorials for guidance on setting up Event Hubs and Stream Analytics.

##License
This project is licensed under the MIT License - see the LICENSE file for details.
