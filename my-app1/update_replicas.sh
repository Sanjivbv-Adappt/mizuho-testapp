#!/bin/bash

# List of application names
app_names=("my-app" "my-app2" "myapp3")

for app_name in "${app_names[@]}"; do
  # Fetch the current manifest for the application
  /mnt/c/tools/argocd.exe app get $app_name -o yaml > deployment.yaml

  # Update the replicas field to 0 in the deployment.yaml file
  sed -i 's/replicas: [0-9]*/replicas: 0/g' deployment.yaml

  # Apply the modified manifest back to the application
  /mnt/c/tools/argocd.exe app set $app_name -f deployment.yaml

  # Synchronize the application
  /mnt/c/tools/argocd.exe app sync $app_name

  # Optionally, you can delete the temporary deployment.yaml file
  # rm deployment.yaml

  echo "Replica count set to 0 for $app_name"
done
