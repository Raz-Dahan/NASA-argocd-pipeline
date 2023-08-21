from google.cloud import storage

def handle_failures(data, context):
    # bucket_name = data['bucket']
    bucket_name = "chart-packages"
    
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    
    blobs = bucket.list_blobs()
    blobs_sorted = sorted(blobs, key=lambda x: x.time_created, reverse=True)
    
    failure_count = 0
    for blob in blobs_sorted:
        if blob.name.startswith('FAILURE-'):
            failure_count += 1
            if failure_count > 5:
                blob.delete()
                print(f"Deleted failure: {blob.name}")
