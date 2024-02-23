# Sends your public key to the instance
resource "aws_key_pair" "paris-region-key-pair" {
  key_name   = "paris-region-key-pair"
  public_key = file(var.public_key_path)
}