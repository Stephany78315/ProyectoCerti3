Para hacer la prueba con la intancia de EC2 creada mandando mensajes a la cola de SQS que se han es necesario estos comandos con
ciertos datos cambiados dependiendo las instancias creadas en cada cuenta propia de AWS.

Cabe destacar que el endpoint-url del comando a través de Internet se mantiene en cambio
el comando de a través del endpoint de la VPC en la sección de endpoint-url se tiene que ingresar el url de su respectivo endpoint creado 
en su cuenta de AWS.

Los datos ingresados son un ejemplo, cada uno lo tiene que cambiar con datos de sus propias instancias creadas en cada cuenta.

A través del Internet: 
E.g. aws sqs send-message
--region us-east-1
--endpoint-url https://sqs.useast-1.amazonaws.com/
--queue-url https://sqs.us-east-1.amazonaws.com/537851388570/standard-sqs-queue/
--message-body “Hello from Public EC2 OVER THE INTERNET”

A través del endpoint de la VPC
E.g. aws sqs send-message
--region us-east-1
--endpoint-url https://vpce-09dda9e06e8a55bba-p0ucf6jb.sqs.us-east-1.vpce.amazonaws.com/
--queue-url https://sqs.us-east-1.amazonaws.com/537851388570/standard-sqs-queue/
--message-body “Hello from Public EC2 OVER VPC INTERNET”
