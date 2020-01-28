#!/bin/bash

host="http://localhost:3000"
user="a@b.com"
pass="123123"

echo "Authenticating $user in $host"

login_params()
{
  cat <<EOF
{
  "email": "${user}",
  "password": "${pass}"
}
EOF
}

login_mutation="mutation ingresar(\$email: String!, \$password: String!) {\
  login(email: \$email, password: \$password) {\
    id\
    name\
    email\
    token\
  }\
}"

token=$( \
  curl -s "${host}/graphql" \
  -H 'Content-Type: application/json' -H 'Accept: application/json' \
  --data-binary "{\"query\":\"${login_mutation}\",\"variables\": $(login_params) }" \
  | jq --raw-output .data.login.token
  )



echo "Authenticated with token: ${token}"


query_string="query test1 {\
  projects {\
    name\
  }\
}"


echo "========================================================================="
echo "Query projects"
echo "${query_string}"
echo "$(params)"
echo "========================================================================="


response=$( \
  curl -L -X POST "${host}/graphql" \
  -H "Authorization: Bearer ${token}" -H "Accept: application/json" -H "Content-Type: application/json" \
  --data-binary "{\"query\":\"${query_string}\"}" \
)

echo "========================================================================="
echo "${response}" | jq
echo "========================================================================="
