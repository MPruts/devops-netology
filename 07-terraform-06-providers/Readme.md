### Задача 1
1. Ссылки где перечислены все доступные resource и data_source: 
   - Ссылка на data_souces - [aws data_sources](https://github.com/hashicorp/terraform-provider-aws/blob/4ba36f7f8d7c14d5ca1705887a7aff9ca5e90edc/internal/provider/provider.go#L344)
   - Ссылка на resources - [aws resources](https://github.com/hashicorp/terraform-provider-aws/blob/4ba36f7f8d7c14d5ca1705887a7aff9ca5e90edc/internal/provider/provider.go#L736)


2. Для создания очереди сообщений SQS используется ресурс aws_sqs_queue у которого есть параметр name.
   - С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано.
     
     Я не смог понять какой конфликт имеется в виду, в силу этого и найти этот самый конфликт не смог. Прошу пояснить в чем заключается суть конфликта и указать на него, так как я не смог его обнаружить.
   - Какая максимальная длина имени?
   
     Длина имени очереди должна быть до 80 символов:
    ```
    // The name of the new queue. The following limits apply to this name:
	//
	//    * A queue name can have up to 80 characters.
	//
	//    * Valid values: alphanumeric characters, hyphens (-), and underscores
	//    (_).
	//
	//    * A FIFO queue name must end with the .fifo suffix.
	//
	// Queue URLs and names are case-sensitive.
	//
	// QueueName is a required field
	QueueName *string `type:"string" required:"true"`
   ```
   - Какому регулярному выражению должно подчиняться имя?
      
     Имя может состоять из латинских символов, цифр, знака "-" и знака "_", имя очереди FIFO должно заканчиваться суффиксом .fifo.