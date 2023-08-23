from google.cloud import storage

def delete_oldest_objects(request): #data, context):
    # bucket_name = data['bucket']
    bucket_name = "chart-packages"
    
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    
    blobs = bucket.list_blobs()
    blobs_sorted = sorted(blobs, key=lambda x: x.time_created)
    
    excess_count = len(blobs_sorted) - 20
    if excess_count > 0:
        for blob in blobs_sorted[:excess_count]:
            blob.delete()

    deletion_message = f"Deleted {excess_count} objects from {bucket_name}."
    return deletion_message
