from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

datasets = list(client.list_datasets())  # Make an API request.
project = client.project

def delete_dataset(dataset_id):
    client.delete_dataset(
        dataset_id, delete_contents=True, not_found_ok=True
    )
    print("Deleted dataset '{}'.".format(dataset_id))    

if datasets:
    print("Datasets in project {}:".format(project))
    for dataset in datasets:
        dataset_id = dataset.dataset_id
        dataset_ = client.get_dataset(dataset_id)
        
        if dataset_id.startswith('dev_') or dataset_id.startswith('ci_'):
            delete_dataset(dataset_id)
else:
    print("{} project does not contain any datasets.".format(project))


