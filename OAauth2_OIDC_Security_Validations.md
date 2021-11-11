# Description

This file list all identified security-oriented validation points that can be performed during code review, configuration review or a penetration test against a system using OAuth2 / OpenID Connect.

# Validation automation status

> Terminology is defined in the **[Terminology](#terminology)** section below.

This section indicates, for each, validation points, if the test is manual or can be automated in a reliable way.

Focus is made on the reliability of the test result. Therefore, in case of doubt, the **manual** way is initially preferred.

## Client

| Validation identifier |       Validation mode       |
|:---------------------:|:---------------------------:|
|         CLT00         |        Automatable          |
|         CLT01         |        Automatable          |
|         CLT02         |           Manual            |
|         CLT03         |        Automatable          |
|         CLT04         |           Manual            |
|         CLT05         |           Manual            |
|         CLT06         |           Manual            |
|         CLT07         |           Manual            |
|         CLT08         |           Manual            |
|         CLT09         |           Manual            |
|         CLT10a        |           Manual            |
|         CLT10b        |           Manual            |
|         CLT10c        |           Manual            |
|         CLT11a        |           Manual            |
|         CLT11b        |           Manual            |
|         CLT12         |        Automatable          |

## Backend-for-Frontend (BFF)

| Validation identifier |       Validation mode       |
|:---------------------:|:---------------------------:|
|         BFF00         |        Automatable          |
|         BFF01         |           Manual            |
|         BFF02         |           Manual            |
|         BFF03         |           Manual            |
|         BFF04         |           Manual            |
|         BFF05         |           Manual            |
|         BFF06         |           Manual            |
|         BFF07         |        Automatable          |
|         BFF08         |           Manual            |

## API

> Note that all tests related to JWT token can leverage [jwt_tool](https://github.com/ticarpi/jwt_tool) for the automation.

| Validation identifier |       Validation mode       |
|:---------------------:|:---------------------------:|
|         API00         |        Automatable          |
|         API01a        |        Automatable          |
|         API01b        |        Automatable          |
|         API01c        |        Automatable          |
|         API01d        |        Automatable          |
|         API01e        |        Automatable          |
|         API02a        |        Automatable          |
|         API02b        |        Automatable          |
|         API02c        |        Automatable          |
|         API03a        |        Automatable          |
|         API03b        |        Automatable          |
|         API03c        |        Automatable          |
|         API04         |        Automatable          |
|         API05         |        Automatable          |
|         API06         |        Automatable          |

## Security Token Service (STS)

| Validation identifier |       Validation mode       |
|:---------------------:|:---------------------------:|
|         STS00a        |        Manual               |
|         STS00b        |        Automatable          |
|         STS00c        |        Manual               |
|         STS00d        |        Manual               |
|         STS01a        |        Manual               |
|         STS01b        |        Manual               |
|         STS01c        |        Manual               |
|         STS02a        |        Manual               |
|         STS02b        |        Manual               |
|         STS03a        |        Manual               |
|         STS03b        |        Manual               |
|         STS03c        |        Manual               |
|         STS04a        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04b        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04c        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04d        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04e        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04f        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04g        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS04h        |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS05         |        Manual               |
|         STS06         |        Automatable if config can be exported as JSON/XML/YAML         |
|         STS07a        |        Manual               |
|         STS07b        |        Manual               |
|         STS07c        |        Manual               |
|         STS08         |        Manual               |
|         STS09         |        Manual               |
|         STS10         |        Automatable          |
|         STS11         |        Automatable          |
|         STS12         |        Automatable          |
|         STS13         |        Automatable via checks against the config from */.well-known/openid-configuration* file          |
|         STS14         |        Automatable via checks against the config from */.well-known/openid-configuration* file          |
|         STS15a        |        Manual               |
|         STS15b        |        Manual               |
|         STS16         |        Manual               |
|         STS17         |        Manual               |
|         STS18         |        Automatable          |
|         STS19         |        Manual               |
|         STS20         |        Manual               |
|         STS21         |        Manual               |
|         STS22a        |        Manual               |
|         STS22b        |        Manual               |

# Application

## Terminology

### User

- OAuth: *Resource Owner*
- OIDC: *End-User*

### Client

- OAuth: *Client*
- OIDC: *Relying Party*

### Security Token Service (STS)

- OAuth: *Authorization Server*
- OIDC: *OpenID Provider*

### API

- OAuth: *Resource Server*
- OIDC: *Not applicable*

## Validations

### User

- None currently

### Client

- CLT00: Ensure that local address `http[s]?://localhost:[0-9]{1,5}` is not allowed in callback uri (parameter *redirect_uri*) or request uri (parameter *request_uri*)
- CLT01: For SPA, ensure that it uses the *Authorization Code Flow with PKCE* instead of the *Implicit flow* or the basic *Authorization Code Flow*
- CLT02: For SPA, if *Implicit flow* is used, ensure the URL is rewritten to prevent the access token from being leaked in any access log or local history
- CLT03: For SPA, ensure A strict *Content-Security-Policy* is in place to mitigate or made harder exploitation of any kind of XSS vulnerability
- CLT04: For SPA, ensure that the app uses a dedicated library/SDK for all OAuth/OIDC operations and not a custom implementation
- CLT05: For SPA, check how it manages the *refresh token* storage and its lifecycle
- CLT06: For SPA, ensure it was using short lifetime for the *access token*
- CLT07: For SPA, ensure that the *access/refresh token* is not disclosed via any URL parameters
- CLT08: For SPA, if the *access token* is a self-contained then ensure that it does not contain any sensitive information.
- CLT09: For SPA, ensure that *refresh token rotations* measures are in place when refresh tokens are used
- CLT10: For Mobile app using *Authorization Code Flow with PKCE*, ensure that:
  - CLT10a: The embedded system browser is used and not a WebView. Indeed, the application must not be able to access to content browsed by the user (for example when he types its credentials to authenticate against the STS).
  - CLT10b: Communication between the app and the embedded system browsers must be achieved by using app launch triggering and parameters carrying using *iOS Universal Links* and *Android App Links* and not *custom URL scheme*.
  - CLT10c: *Access and refresh tokens* are stored in a way that they are ciphered when at rest.
- CLT11: For OIDC authentication flow, ensure that the following 2 claims of the *identity Token* are verified:
  - CLT11a: *iss*: Issuer of the token (the STS).
  - CLT11b: *aud*: Audience of the token. This must match the identifier of the client, since the client is the intended target audience of identity tokens.
- CLT12: If the basic *Authorization Code Flow* is used then ensure that a non-guessable, unique, one-time used *state* is used and is correctly validated.

### Backend-for-Frontend (BFF)

- BFF00: Ensure that the session cookie contains all possible built-in protection
- BFF01: Ensure that a new session is issued when a new set of tokens are obtained by the BFF (ex: login phase)
- BFF02: Ensure that the session is immediately revoked when the user calls the *logout* endpoint
- BFF03: Ensure that the BFF leverage the built-in session feature of the implementation framework/technology
- BFF04: Ensure that BFF is not prone to SSRF and take all information like API host/route from the server-side configuration
- BFF05: Ensure that session lifetime is aligned with *refresh token* lifetime
- BFF06: Ensure that the BFF use *sender-contained tokens*
- BFF07: If the BFF perform some content transformation (e.g.: XML to JSON, form to JSON, etc.) then it is not prone to parser abuse (e.g.: XXE).
- BFF08: Ensure that access/refresh/identity tokens are never disclosed by the BFF in any case

### API

- API00: Ensure that call is rejected if provided token is a *refresh/identity* token
- API01: Ensure for *self-contained* access token:
  - API01a: The algorithm is not taken from the header *but fixed by configuration*
  - API01b: Get the verification public key from the STS (using the *jwks_uri* endpoint) based on the *kid* claim
  - API01c: The signature is valid
  - API01d: Token is not expired
  - API01e: The claim *azp* refer to a *clientId* known by the STS: Normally it's already the case due to the *access token* provided to the *Client* but it is a paranoid validation
- API02: Ensure for *reference* access token  - Get information about the token using the STS token introspection endpoint:
  - API02a: STS know this token (get a valid response)
  - API02b: Token is active via the *active* claim
  - API02c: The claim *clientId* refer to a *Client* known by the STS: Normally it's already the case due to the valid reply received with the *access token* but it is a paranoid validation
- API03: Ensure, whatever the type of token, that the access token:
  - API03a: Contains the claims expected for authorization decisions
  - API03b: The audience claim *aud* for which the access token was targeted is the API
  - API03c: The issuer claim *iss* is the STS identifier
- API04: Ensure that the API rejects any access token containing a *scope* not defined in the OIDC specifications (OAuth specifications do not define specific scope values) and API context
- API05: Ensure that the API fails safely when *some scope is missing* (if STS allows selecting consent among a list of proposed ones or if consent is refused by the user)
- API06: Ensure that API verify that the data accessed for read, update or delete operation by the current *Client* is consistent from business logic point of view: *Check exposure to data level access control issues*

### STS

- STS00: For *Authorization Code Flow with PKCE*, ensure that:
     - STS00a: The *CodeVerifier* value cannot be recovered (brute force, disclosure, etc.) based on the knowledge of the *CodeChallenge* value (as it is passed in the URL redirections)
     - STS00b: The STS does not support broken hashing algorithms like MD5 or SHA1 or even "plain" (means *CodeChallenge* == *CodeVerifier*)
     - STS00c: If during the *Code Exchange* phase, the code verifier provided is invalid (the STS must reply *Failed to verify code verifier*) then ensure that the provided *Authorization Code* is immediately invalidated
     - STS00d: Ensure that a Code Verifier value is used only one-time at all
- STS01: Ensure that the *Authorization Code* delivered to client:
  - STS01a: Have a limited lifetime
  - STS01b: Is one-time usage, non-guessable and not reused at all
  - STS01c: Cannot be exchanged for an access token without providing valid client credentials or code verifier
- STS02: Ensure that the *Callback URLs* specified in the *redirect_uri* parameter is strictly validated against the ones defined during the client registration when a flow is initiated. Precisely ensure prevention against following abuses:
  - STS02a: URL parsing abuses like `https://expected-host@evil-host` or `https://expected-host#evil-host` or `https://default-host.com&@foo.evil-user.net#@bar.evil-user.net/`, see `@` and `#` characters
  - STS02b: *Parameter pollution vulnerabilities* by adding *redirect_uri* parameters several times in the request like `https://sts.com?client_id=123&redirect_uri=client-app.com/callback&redirect_uri=evil-user.net`
- STS03: Ensure, regarding the *refresh Token*, that:
  -  STS03a: Have a limited lifetime
  -  STS03b: The STS requires authentication to exchange it against an access token for *confidential client* (for public client is a bearer)
  -  STS03c: It can be only used to obtain an *access token* for the target *Audience* specified during the obtaining of the *refresh token*
- STS04: Ensure that for a *Client*, the following settings a set to a secure value:
     - STS04a: Token Endpoint Authentication Method
     - STS04b: Allowed Web Origins
     - STS04c: Allowed Origins (CORS)
     - STS04d: Refresh Token Rotations and its reuse interval
     - STS04e: Refresh Token Expirations: Absolute Expiration, Absolute Lifetime, Inactivity Expiration, Inactivity Lifetime
     - STS04f: JSON Signature Algorithm
     - STS04g: Cross-Origin Verification Fallback
     - STS04h: Allowed Grant Types (flow types enabled) and Response Modes
- STS05: Ensure that the session cookie contains all possible built-in protection
- STS06: Ensure that *refresh token rotation* is in place for SPA type of *Client*
- STS07: When *refresh token rotation* is used:
     - STS07a: Ensure that STS is able to detect a *refresh token re-use* and then revoke the entire refresh token chain
     - STS07b: A *refresk token* can only be used one-time
     - STS07c: When the *reuse interval* option is enabled, ensure that is set to the minimum possible (less than a minute) and is correctly enforced by the STS
- STS08: Ensure that a *refresh token* have an absolute lifetime that cannot be abused to gain eternal possibility to *obtain access* tokens via the different *refresh tokens* issued by the STS
- STS09: Ensure that the STS revoke the current valid *refresh token* in case of inactivity
- STS10: Ensure that STS only enables, for a *Client*, only the *Response Mode* (parameter *response_mode*) expected according to the kind of OAuth/OIDC flow used by the *Client*
- STS11: Ensure that the *token introspection endpoint* requires authentication (client credentials, basic authentication, client TLS certificates, etc.) from every *Client*
- STS12: Ensure that the STS rejects any request (flow init) specifying a *scope* that is not defined for the targeted API and prevent *scope enumeration/discovery operation*
- STS13: Ensure that the STS only supports *asymmetric algorithms* (RSA/EC) for the signature of access/refresh/identity self-contained token (JWT) issued
- STS14: Ensure that the STS does not support the *NONE algorithms* for the signature of access/refresh/identify self-contained token (JWT) issued
- STS15: Ensure if Client self-registration is enabled that:
  - STS15a: It requires Client information strong validation (email, identity, IP, etc.) prior that access was enabled and credentials were delivered.
  - STS15b: During registration that parameters *logo_uri*, *jwks_uri*, *sector_identifier_uri*, *request_uris*, *client_uri*, *policy_uri*, *tos_uri*, *initiate_login_uri* do not expose the STS to SSRF. See the section named *Dynamic Client Registration, SSRF by design* of this [blog post](https://portswigger.net/research/hidden-oauth-attack-vectors) for exploitation details.
- STS16: If the *request_uri* parameter is supported by the STS during the init of a flow then ensure that it does not expose the STS to SSRF. See the section named *Dynamic Client Registration, SSRF by design* of this [blog post](https://portswigger.net/research/hidden-oauth-attack-vectors) for exploitation details.
- STS17: Ensure that the STS is not prone to the "redirect_uri Session Poisoning" attack. See the section named *Chapter two: "redirect_uri" Session Poisoning* of this [blog post](https://portswigger.net/research/hidden-oauth-attack-vectors) for exploitation details.
- STS18: Ensure that the STS is not prone to *Issuer* enumeration via the support of the [OpenID Provider Issuer Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html#IssuerDiscovery) feature. See the section named *Chapter three: "/.well-known/webfinger" makes all user names well-known* of this [blog post](https://portswigger.net/research/hidden-oauth-attack-vectors) for exploitation details
- STS19: For *Implicit* and *Hybrid* flows, ensure that the *id token* include the *nonce* (cryptographically random string that your app adds to the initial request and is included inside the *id token* to prevent [token replay attacks](https://auth0.com/docs/authorization/mitigate-replay-attacks-when-using-the-implicit-flow))
- STS20: For [Hybrid flow](https://openid.net/specs/openid-connect-core-1_0.html#HybridFlowAuth)  - Ensure that the *id token* includes the *c_hash* claim that is a hash of the authorization code exchanged to obtain it, see [here](https://auth0.com/docs/flows/call-api-hybrid-flow#response) for technical details about this validation. See [here](https://openid.net/specs/openid-connect-core-1_0.html#HybridIDToken) for details about how this hash is computed
- STS21: For [Hybrid flow](https://openid.net/specs/openid-connect-core-1_0.html#HybridFlowAuth)  - Ensure that the *id token* include the *at_hash* claim that is a hash of the *access token* issued at the same time than the *id token*. See [here](https://openid.net/specs/openid-connect-core-1_0.html#HybridIDToken) for details about how this hash is computed
- STS22: If the parameter [claims](https://openid.net/specs/openid-connect-core-1_0.html#ClaimsParameter) is supported by the STS:
     - STS22a: Ensure that is not possible to override, in the *id token*, sensitive claims that are parts of the [Standard Claims](https://openid.net/specs/openid-connect-core-1_0.html#StandardClaims) set like *iss*, *aud*, *sub*, *azp*, *nonce*, *at_hash* 
       - Raw test value to URL encode: `{"id_token":{"sub":{"essential": true,"value":"changed"}}}`  
     - STS22b: Ensure that in the *id token* and *UserInfo* endpoint the claims named *profile*, *picture*, *website* are not prone to SSRF by fixing their value via the *claims* parameter
       - Raw test value to URL encode: `{"id_token":{"profile":{"essential": true,"value":"http://listener.com/1"},"picture":{"essential": true,"value":"http://listener.com/2"},"website":{"essential": true,"value":"http://listener.com/3"}}, "userinfo":{"profile":{"essential": true,"value":"http://listener.com/4"},"picture":{"essential": true,"value":"http://listener.com/5"},"website":{"essential": true,"value":"http://listener.com/6"}}}`   
