from google.cloud import storage

def handle_failures(request): #data, context):
    # bucket_name = data['bucket']
    bucket_name = "chart-packages"
    
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    
    blobs = bucket.list_blobs()
    blobs_sorted = sorted(blobs, key=lambda x: x.time_created, reverse=True)
    
    failure_count = 0
    deleted_failure_count = 0
    deletion_message = ""
    
    for blob in blobs_sorted:
        if blob.name.startswith('FAILURE-'):
            failure_count += 1
            if failure_count > 5:
                blob.delete()
                deleted_failure_count += 1
                deletion_message += f"Deleted failure: {blob.name}\n"

    if deleted_failure_count > 0:
        return deletion_message
    else:
        return "No failures were deleted."
