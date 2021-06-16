**/.terraform/* ----- рекурсивно во всех каталогах исключить содержимое каталога ".terraform"

*.tfstate ----- игнорировать файлы с расширением tfstate
*.tfstate.* ----- исключить файлы в которых содержится .tfstate.

crash.log ----- исключить файлы crash.log

*.tfvars ----- исключить файлы с расширением tfvars

override.tf ----- исключить файлы override.tf
override.tf.json ----- исключить файлы override.tf.json
*_override.tf ----- исключить файлы содержащие _override.tf
*_override.tf.json ----- исключить все файлы содержащие _override.tf.json

.terraformrc ----- исключить файлы с расширением .terraformrc
terraform.rc ----- исключить файлы terraform.rc
