# CI/CD Project

This GitHub Actions workflow automates the building, testing, deploying, and monitoring process for a Kubernetes application using Docker, Helm, and Google Cloud Platform (GCP) services. <br />
This pipeline gives developers the option to deploy their app with a simple push.

## Workflow Overview

![Pipeline's Diagram](https://raz-jpgs-archive.s3.eu-central-1.amazonaws.com/diagram.jpg)

🛠️ **Build**: The workflow starts with building a Docker image of the application, pushing it to Docker Hub, packaging the Helm chart and upload it to GCP bucket.

✅ **Test**: After building, the application is deployed to a test cluster using the Helm chart. Helm tests are then executed on the deployed application.

🌐 **Deploy**: Upon successful testing, the application is deployed to a production cluster using the Helm chart.

📈 **Monitor**: Finally, the monitoring components (Prometheus and Grafana) are installed on the production cluster if not already present.

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

3. That's it! Push your code changes to the `main` branch to trigger the workflow.

- GCP serverless Cloud Functions can be triggered automatically using an event trigger, but due to financial considerations, it is triggered manually during the `cleanups` job in the workflow.