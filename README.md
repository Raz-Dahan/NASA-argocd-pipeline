# CI/CD Project

This GitHub Actions workflow streamlines the continuous integration (CI) process for a Kubernetes application. It leverages Docker, Helm, and Google Cloud Platform (GCP) services and integrates with Argo CD for efficient application delivery (CD)

## Workflow Overview

![Pipeline's Diagram](https://raz-jpgs-archive.s3.eu-central-1.amazonaws.com/argo-diagram.jpg)

🛠️ **Build**: The workflow starts with building a Docker image of the application, pushing it to Docker Hub, packaging the Helm chart and upload it to GCP bucket.

✅ **Test**: After building, the application is deployed to a test environment using the Helm chart. Helm tests are then executed on the deployed application.

🌐 **Deploy**: Upon successful testing, the application can be deployed to the production environment manually through Argo CD. 

📈 **Optimization**: Finally, the monitoring components (Prometheus and Grafana) are installed on the cluster if not already present and Cleanups are made using Serverless GCP Cloud Functions.

## Workflow Setup

1. Ensure you have these credentials saved as secrets in your repository settings:

   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password.
   - `API_KEY` : Your app API key , if there is a need
   - `GCP_SERVICE_ACCOUNT_KEY`: Contents of your GCP service account key JSON file.

2. Configure the required environment variables in your `.github/workflows/workflow.yaml`:

   - `PROJECT_ID`: Your GCP project ID.
   - `BUCKET_NAME`: Name of the GCP bucket to store Helm packages.
   - `HELM_PACKAGE`: Helm package file name.
   - `TAG`: Tag for Docker image and Helm chart version coming from `versionung.sh`.

3. That's it! Push your code changes to the `test` branch to trigger the CI workflow.

3. If it was successful Push your code changes to the `main` and manually sync production environment in Argo CD.

- GCP serverless Cloud Functions can be triggered automatically using an event trigger, but for clarity, it is triggered manually during the `postD_workflow.yaml` with Prometheus and Grafana as well.
