variable "project" {
  description = "Project"
  default     = "ny-rides-447816"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "europe-west1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default = "EU"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default = "ny_rides_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "ny_rides_bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
