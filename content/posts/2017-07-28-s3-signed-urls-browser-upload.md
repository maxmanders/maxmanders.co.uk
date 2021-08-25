---
title: S3 Browser Upload And S3 Signed URLs
date: 20017-07-28
---
If you want to distribute content for a limited period of time, or allow users to upload content, S3 signed URLs are an
ideal solution. Any AWS IAM principal can generate a signed URL, but in order for that signed URL to be useful, the
principal that generated the URL must have the necessary permissions to use it. For example, if you would like Joanne to
upload a file to an object in an S3 bucket you own, using a signed URL, the principal that generated the signed URL must
have permissions to upload to that object key.

In this post, I'll walk you through how you might generate a signed URL, and then use it to upload a file to S3 from the
browser. The example uses Python, but a similar approach should work with other languages, using an appropriate AWS
client library. In this example, we'll assume that the Python code generating the signed URL is being executed on an AWS
EC2 instance, which has a suitable permissive IAM role attached to it.

## Getting Started

For the sake of this example, we'll assume we're uploading to a bucket called 'foobucket', and using a key prefix of
'bar/baz'.

Your S3 bucket will need a suitable CORS policy. You can further restrict this policy, but the following will suffice
for this example.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
  <AllowedOrigin>*</AllowedOrigin>
  <AllowedMethod>GET</AllowedMethod>
  <AllowedMethod>PUT</AllowedMethod>
  <AllowedMethod>POST</AllowedMethod>
  <AllowedMethod>HEAD</AllowedMethod>
  <MaxAgeSeconds>3000</MaxAgeSeconds>
  <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

We'll also work with CSV files. When you make a *PUT* request to upload a file to the signed URL, the S3 service will
generate a signature using the same parameters that were used to generate the signed URL.  This means that if you
generate a signed URL for a *PUT* request to an object with a Content-Type header of 'text/csv', the request to the
signed URL will only be accepted if the HTTP verb and Content-Type match. If you find you're seeing HTTP 403 responses,
keep this in mind.

If you have the AWS CLI available on your EC2 host, you can verify that it has the necessary permissions, by trying to
upload a file to your target bucket.

```bash
user@host:~$ cat>/tmp/test.csv<<EOF
> id,firstname,lastname
> 1,max,manders
> EOF
user@host:~$ aws s3api put-object \
  --bucket foobucket \
  --key bar/baz/test.csv \
  --body /tmp/test.csv
{
    "ETag": "\"08083e4b01c00d14893a89e9c34797ef\""
}
```

## Generating The Signed URL

The Python code below is necessary minimal, and contains no error handling.

```python
import boto3

bucket = 'foobucket'
prefix = 'bar/baz'
key = 'test.csv'
s3_client = boto3.client('s3')

def get_signed_url(s3_client=None, bucket=None, prefix=None, key=None, content_type=None):
  url = s3_client.generate_presigned_url(
    ClientMethod='put_object',
    Params={
      'Bucket': bucket,
      'Key': "{}/{}".format(prefix, key),
      'ContentType': content_type
    })

  return url

url = get_signed_url(s3_client, bucket, prefix, key, 'text/csv')
```

Heads up, I'm an Operations Engineer, so there may be neater ways to write this code. You might use this code while you
generate an HTML response. You could render the URL as a hidden form field in the HTML. You could generate N URLs for N
potential uploads, dynamically generating the object key. You might instead generate JavaScript on the server, and
include the URL as a JavaScript variable. It's entirely up to you. Note that the *generate*presigned_url_ function can
optionally take a duration after which to expire the URL. If omitted, the URL will expire after one hour.

## The Browser

We can use a very simple form to demonstrate the process.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>S3 Signed URL Upload Test</title>
  </head>
  <body>
    <form id="theForm" method="POST" enctype="multipart/form-data" >
        <input id="theFile" name="file" type="file"/> 
        <button id="theButton" type="submit">Submit</button>
    </form>
  </body>
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="upload.js"></script>
</html>
```

I'm using JQuery to make things a little easier. Notice that we're including 'upload.js', which you'll find below.

```javascript
/*
 * Your URL will look something like this. I've removed some of the parameters from the URL, and replaced them with
 * <>. I've also included browser console logging, so you can see what's going on. How you get this URL into your
 * JavaScript is up to you. I've defined a variable here for illustration.
 */
var the_url="https://foobucket.s3.amazonaws.com/bar/baz/test.csv?AWSAccessKeyId=<>&content-type=text%2Fcsv&Expires=3600&x-amz-security-token=<>&Signature=<>'

$(function() {
  console.log('Signed URL: ' + the_url);

  $('#theForm').on('submit', sendFile);
});

function sendFile(e) {
  e.preventDefault();
  console.log('Sending file');

  var theFormFile = $('#theFile').get()[0].files[0];
  console.log(theFormFile);

  var result = $.ajax({
    type: 'PUT',
    url: the_url,
    contentType: 'text/csv',
    processData: false,
    data: theFormFile,
    success: function(req, err) {
      console.log('File uploaded: ' + err);
    },
    error: function(req, err) {
      console.log('File NOT uploaded: ' + err);
    }
  });

  return false;
}
```

Walking through the code, we first add a handler for our form's *onsubmit* event. Next, we define the *onsubmit* event
handler. We first prevent the form's default action, i.e. submitting the form. We want to handle that ourselves via an
asynchronous request to our signed URL.

Next, we use JQuery's AJAX functionality to make creating and using the XHR object a bit easier. Pay particular
attention to lines 21 and 23. Here we set the HTTP verb that we used when generating the signed URL. We also set the
same content type.

## Summary

There you have it, a very basic example of generating and using signed S3 URLs to upload files to S3 from the browser.
I hope this proves useful.
