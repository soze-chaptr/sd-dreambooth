# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# authoritative project-iam-bindings to increase reproducibility
module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [var.project_id]
  mode     = "authoritative"

  bindings = {
    "roles/logging.logWriter" = [
        "serviceAccount:${google_service_account.vertexai_training.email}",
        "serviceAccount:${google_service_account.vertexai_prediction.email}",
        "serviceAccount:${google_service_account.cloudbuild.email}",
    ],
    "roles/aiplatform.admin" = [
        "serviceAccount:${google_service_account.vertexai_training.email}", # TODO: determine and assign minimal permissions
    ]
  }
}