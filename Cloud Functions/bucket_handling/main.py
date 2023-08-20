from google.cloud import storage

def delete_oldest_objects(data, context):
    bucket_name = data['bucket']
    
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    
    blobs = bucket.list_blobs()
    blobs_sorted = sorted(blobs, key=lambda x: x.time_created)
    
    excess_count = len(blobs_sorted) - 20
    if excess_count > 0:
        for blob in blobs_sorted[:excess_count]:
            blob.delete()

    print(f"Deleted {excess_count} objects from {bucket_name}.")
