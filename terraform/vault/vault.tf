provider vault {
  address = "http://192.168.122.113:8200"
}

data vault_generic_secret mycred {
  path = "secret/db_creds"
}

output mysecret {
  value = data.vault_generic_secret.mycred
  sensitive = true
}
