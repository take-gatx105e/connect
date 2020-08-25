require "refile/s3"

if Rails.env.production? # 本番環境の場合はS3へアップロード
  aws = {
    access_key_id: Rails.application.credentials.aws[:access_key_id],
    secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    # access_key_id: "AWS_ACCESS_KEY_ID",
    # secret_access_key: "AWS_SECRET_ACCESS_KEY",
    region: "ap-northeast-1",
    bucket: Rails.application.credentials.aws[:bucket],
  }
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)
end