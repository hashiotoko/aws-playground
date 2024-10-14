import { Construct } from 'constructs';
import { App, TerraformStack } from 'cdktf';
import * as aws from '@cdktf/provider-aws';

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    // define resources here
    new aws.provider.AwsProvider(this, 'provider', {
      region: 'ap-northeast-1',
    });

    const dynamodb = new aws.dynamodbTable.DynamodbTable(
      this,
      'test-dynamodb',
      {
        name: 'test_user',
        billingMode: 'PAY_PER_REQUEST',
        hashKey: 'UserId',
        attribute: [{ name: 'UserId', type: 'S' }],
      }
    );

    new aws.dynamodbTableItem.DynamodbTableItem(this, 'test-dynamodb-item', {
      tableName: dynamodb.name,
      hashKey: dynamodb.hashKey,
      item: JSON.stringify({
        UserId: { S: '1' },
        FirstName: { S: 'Taro' },
        LastName: { S: 'Tanaka' },
      }),
    });
  }
}

const app = new App();
new MyStack(app, 'apigw-lambda-dynamodb-cdktf');
app.synth();
