## postman前置脚本-hmac

```javascript
function strFormatMap(template, map) {
  var out = template;
  Object.keys(map).forEach(function(key) {
    out = out.replace("${" + key + "}", map[key]);
  });
  return out;
}

function getHeadersString(sigHeaders) {
  var headers = "";
  Object.keys(sigHeaders).forEach(function(h) {
    if (headers !== "") headers += " ";
    headers += h;
  });
  return headers;
}

function getSigString(sigHeaders) {
  var sigString = "";
  Object.keys(sigHeaders).forEach(function(h) {
    if (sigString !== "") sigString += "\n";
    if (h.toLowerCase() == "request-line") sigString += sigHeaders[h];
    else sigString += h.toLowerCase() + ": " + sigHeaders[h];
  });
  return sigString;
}

function hashString(algorithm, str, secret) {
  switch (algorithm) {
    case "hmac-sha1":
      return CryptoJS.HmacSHA1(str, secret);
    case "hmac-sha256":
      return CryptoJS.HmacSHA256(str, secret);
    case "hmac-sha512":
      return CryptoJS.HmacSHA512(str, secret);
    default:
      return null;
  }
}

dateHeader = new Date().toGMTString();
targetUrl = request.url.trim().replace(new RegExp("^(https?://[^/]+/)|(\{\{Host\}\})/"), "/");
requestLine = request.method + " " + targetUrl + " HTTP/1.1";

// Get the content-type header
var contentType = request.headers["content-type"];

// Set headers for the signature hash
var sigHeaders = {
  "request-line": requestLine,
  "x-date": dateHeader,
  "content-type": contentType
};

// Set the key ID and secret
var keyId = pm.environment.get("SecretId");
var secret = pm.environment.get("SecretKey");
var algorithm = "hmac-sha256";

var authHeaderTemplate =
  'hmac username="${keyId}",algorithm="${algorithm}",headers="${headers}",signature="${signature}"';

// Get the list of headers
var headers = getHeadersString(sigHeaders);
// Build the signature string
var sigString = getSigString(sigHeaders);
// Hash the signature string using the specified algorithm
var sigHash = hashString(algorithm, sigString, secret);

// Format the authorization header
var authHeader = strFormatMap(authHeaderTemplate, {
  keyId: keyId,
  algorithm: algorithm,
  headers: headers,
  signature: CryptoJS.enc.Base64.stringify(sigHash)
});

// Set Postman environment variables for the headers
postman.setEnvironmentVariable("X-Date", dateHeader);
postman.setEnvironmentVariable("Authorization", authHeader);
```

