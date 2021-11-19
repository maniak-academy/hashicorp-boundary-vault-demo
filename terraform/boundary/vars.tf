variable "url" {
  default = "http://boundary-test-controller-beagle-a24bbd1674492edf.elb.us-east-1.amazonaws.com:9200/"
}

variable "backend_team" {
  type = set(string)
  default = [
    "jim",
    "mike",
    "todd",
  ]
}

variable "frontend_team" {
  type = set(string)
  default = [
    "randy",
    "susmitha",
  ]
}

variable "leadership_team" {
  type = set(string)
  default = [
    "jeff",
    "pete",
    "jonathan",
    "malnick"
  ]
}

variable "target_ips" {
  type    = set(string)
  default = [
   "10.0.100.11",
   "10.0.100.8",
   ]
}

variable "kms_recovery_key_id" {
  default = ""
}
