

# outbox-receivable-anticipation

## Source tasks

Task que consome da tabela outbox e envia para o tópico `cmd.dsr.psp.receivable.anticipation.anticipation-data-service-created`.

### Status

```sh
curl -X GET http://bkofin-kafka-connect.gl.mesos.pagseguro.intranet/connectors/prod-outbox-receivable-anticipation-data-service-created-v6/status
```

### Pause

```sh
curl -X PUT http://bkofin-kafka-connect.gl.mesos.pagseguro.intranet/connectors/prod-outbox-receivable-anticipation-data-service-created-v6/pause
```

### Resume

```sh
curl -X PUT http://bkofin-kafka-connect.gl.mesos.pagseguro.intranet/connectors/prod-outbox-receivable-anticipation-data-service-created-v6/resume
```

### Delete

```sh
curl -X DELETE http://bkofin-kafka-connect.gl.mesos.pagseguro.intranet/connectors/prod-outbox-receivable-anticipation-data-service-created-v6
```
### Restart

```sh
curl -X POST http://bkofin-kafka-connect.gl.mesos.pagseguro.intranet/connectors/prod-outbox-receivable-anticipation-data-service-created-v6/restart
```
### new



{
  "name": "prod-outbox-receivable-anticipation-data-service-created-v6",
  "config": {
    "name": "prod-outbox-receivable-anticipation-data-service-created-v6",
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "tasks.max": "1",
    "poll.interval.ms": "1200000",
    "batch.max.rows": "5000",
    "tombstones.on.delete": "false",
	"topic.prefix": "cmd.dsr.psp.receivable.anticipation.anticipation-data-service-created",	
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.use.latest.version": "true",
    "value.converter.enhanced.avro.schema.support": "true",
    "value.converter.schema.registry.url": "http://schema-registry.prd-aws.intranet.pagseguro.uol:8081",
    "value.converter.auto.register.schemas": "true",
    "value.converter.schemas.enable": "true",
    "value.converter.connect.meta.data": "false",	
    "mode": "timestamp",
    "timestamp.column.name": "dat_update",
    "timestamp.delay.interval.ms": "10000",
    "query": "select idt_anticipation,idt_safepay_user,ind_account_type,ind_anticipation_origin,idt_anticipation_info,idt_advanceable_receivable,num_version,dat_creation at time zone 'America/Fortaleza' AS dat_creation, dat_update at time zone 'America/Fortaleza' AS dat_update, ind_status,idt_advanceable_receivable_parent,cod_uuid_anticipation,idt_anticipation_parent,cod_customer,flg_completion_integration, nam_change_agent from anticipation_data_service_adm.anticipation WHERE dat_update > ? at time zone 'America/Fortaleza' AND dat_update <= ? at time zone 'America/Fortaleza' ORDER BY dat_update ASC --",
	"transforms": "createKey,extractInt,insights,SetSchemaMetadata,AddNamespace,Cast,RenameField",
	"transforms.AddNamespace.type" : "org.apache.kafka.connect.transforms.SetSchemaMetadata$Value",
	"transforms.AddNamespace.schema.name" : "data.xpress.ps.acquirer.receivables.anticipation", 
    "transforms.createKey.type": "org.apache.kafka.connect.transforms.ValueToKey",
    "transforms.createKey.fields": "idt_safepay_user", 
    "transforms.extractInt.type": "org.apache.kafka.connect.transforms.ExtractField$Key",
    "transforms.extractInt.field": "idt_safepay_user", 
    "transforms.insights.type": "br.com.pagseguro.kafka.smt.NewRelicInsights$Value",
    "transforms.insights.connector.name": "prod-outbox-receivable-anticipation-data-service-created-v6",
    "transforms.insights.connector.type": "source",
	"transforms.SetSchemaMetadata.type": "org.apache.kafka.connect.transforms.SetSchemaMetadata$Value",
	"transforms.SetSchemaMetadata.schema.version": "6",
	"transforms.Cast.type": "org.apache.kafka.connect.transforms.Cast$Value",
	"transforms.Cast.spec": "dat_creation:string,dat_update:string",
	"transforms.RenameField.type": "org.apache.kafka.connect.transforms.ReplaceField$Value",
    "transforms.RenameField.renames": "idt_advanceable_receivable_parent:idt_advanceable_rec_parent",
    "connection.user": "kafka_anticipationdataserviceubr",
    "connection.password": "Pr9Kf5S#4UnR#QwXCpw",
    "connection.url": "jdbc:postgresql://anticipationdataservice.coid1xsnbqhf.sa-east-1.rds.amazonaws.com:5432/anticipation_data_service", 
    "connection.backoff.ms": "1000",
    "connection.attempts": "3"	
  }
}