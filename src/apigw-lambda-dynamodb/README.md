# API Gateway + Lambda + DynamoDB with IP制限

## 基本構成 ref

* https://tech.furyu.jp/entry/2023/06/26/180737
* https://tech.furyu.jp/entry/2023/06/30/161024
* https://qiita.com/yuta-katayama-23/items/7055c1a2e5a9cddf7a76
* https://qiita.com/yamapyblack/items/c037c4e07123929d9046
* https://zenn.dev/tkg216/articles/c9aede81c20a8e
* https://zenn.dev/kyuko/articles/69d612bf8ad201
* https://developer.hashicorp.com/terraform/language/expressions/types
* https://qiita.com/Hikosaburou/items/1d3765d85d5398e3763f#tfvars-%E3%81%AB%E5%80%A4%E3%82%92%E5%9F%8B%E3%82%81%E8%BE%BC%E3%82%80

## terraform ref

* https://oji-cloud.net/2022/04/15/post-7028/
* https://oji-cloud.net/2022/02/19/post-6926/
* https://zenn.dev/coconala/articles/7a49fee9893c95
* https://techblog.forgevision.com/entry/Terraform/directory
* https://www.cloudbuilders.jp/articles/4659/
* https://envader.plus/article/474

## cdktf

* https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-install
* https://dev.classmethod.jp/articles/ckd_for_terraform_first_touch/
* https://zenn.dev/yutaro1985/articles/cdktf-for-usual-terraform-users

## その他

* https://speakerdeck.com/yayoi_dd/i-tried-using-cdk-for-terraform
* https://dev.classmethod.jp/articles/cdk-for-terraform-aws-adapter-aws-cdk-construct/
  * 現状、cdktf では L1 Coonstruct レベルのものしか指定できないが、[AWS Adapter(technical preview)](https://developer.hashicorp.com/terraform/cdktf/create-and-deploy/aws-adapter) を使用することで AWS Cloud Control API 経由で L2 L3 Construct などを使用できる
