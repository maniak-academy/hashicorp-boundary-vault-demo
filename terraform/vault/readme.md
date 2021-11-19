 vault token create \
  -no-default-policy=true \
  -policy="boundary-controller" \
  -policy="boundary-target" \
  -orphan=true \
  -period=30m \
  -renewable=true


  Unseal Key 1: jUjHbtuXpVLhuxgugUkYTXN2BtW9G+oVO0HnWFWQZo0=

Initial Root Token: s.G00F0Fcm447vvwducw5PFtOZ

 vault token create \
  -no-default-policy=true \
  -policy="boundary-controller" \
  -policy="boundary-target" \
  -orphan=true \
  -period=3600m \
  -renewable=true



vault operator init \
    -key-shares=1 \
    -key-threshold=1 \

    Unseal Key 1: zOXem8POn98gXBZQq2lfTHEMWcwh2M8mYQ8v46yW0+4=

Initial Root Token: s.wit0f2v5Dr4NJmoKOnDv2r6C