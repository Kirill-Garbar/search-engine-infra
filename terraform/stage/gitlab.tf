resource "google_compute_instance" "gitlab" {
  name         = "gitlab"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["gitlab-server", "http-server", "https-server", "git-server"]

  boot_disk {
    initialize_params {
      image = "${var.gitlab_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

# resource "google_dns_record_set" "search_engine_zone" {
#   name         = "gitlab.${google_dns_managed_zone.search_engine_zone.dns_name}"
#   managed_zone = "${google_dns_managed_zone.search_engine_zone.name}"
#   type         = "A"
#   ttl          = 30

#   rrdatas = ["${google_compute_instance.gitlab.network_interface.0.access_config.0.nat_ip}"]
# }



resource "google_dns_record_set" "search_engine_zone" {
  name         = "gitlab.${var.search_engine_dns_zone}."
  managed_zone = "${replace(var.search_engine_dns_zone,".", "-")}"
  type         = "A"
  ttl          = 30

  rrdatas = ["${google_compute_instance.gitlab.network_interface.0.access_config.0.nat_ip}"]
}
