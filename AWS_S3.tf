 



# bucket creation     To run this block alone will create bucket with ACL disabled mode which means bucket and object are in private 
resource "aws_s3_bucket" "mybucketsa16032024" {

  bucket = "mybucketsa16032024"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


# bucket versioning 
resource "aws_s3_bucket_versioning" "mybucketsa16032024" {
  bucket = aws_s3_bucket.mybucketsa16032024.id
  versioning_configuration {
    status = "Enabled"
  }
}

# enabling ACL which mean bucket is public     (block all public  )

resource "aws_s3_bucket_public_access_block" "mybucketsa16032024" {
  bucket = aws_s3_bucket.mybucketsa16032024.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# enabling the owner ship of the bucket 


resource "aws_s3_bucket_ownership_controls" "mybucketsa16032024" {
  bucket = aws_s3_bucket.mybucketsa16032024.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


# ACL enabling 

resource "aws_s3_bucket_acl" "mybucketsa16032024" {


    bucket = aws_s3_bucket.mybucketsa16032024.id
     acl    = "private"     # Objects can be public

    # acl    = "private"  # public
 
 
    depends_on = [
    aws_s3_bucket_ownership_controls.mybucketsa16032024,
    aws_s3_bucket_public_access_block.mybucketsa16032024,
  ]

  
}


