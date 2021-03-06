# OAuth2OIDC-Study

[![update_mindmap_image](https://github.com/ExcelliumSA/OAuth2OIDC-Study/actions/workflows/update-mindmap-image.yml/badge.svg)](https://github.com/ExcelliumSA/OAuth2OIDC-Study/actions/workflows/update-mindmap-image.yml)

Contains the materials used for the blog post about [OAuth2 and OpenID Connect](https://courses.pragmaticwebsecurity.com/courses/introduction-to-oauth-2-0-and-openid-connect).

# Blog post link

https://excellium-services.com/2021/10/22/how-to-evaluate-an-oauth-openid-connect-system-from-a-security-point-of-view/

# Security validations points

> This [script](https://github.com/righettod/toolbox-pentest-web/blob/master/scripts/identify-attack-surface-oauth-oidc-sts.py) was created to automate as much tests as possible.

They are defined in this [file](OAauth2_OIDC_Security_Validations.md).

Mind map overview mode:

![OAauth2_OIDC_Security_Validations](OAauth2_OIDC_Security_Validations.png)

:speech_balloon: Mind map image is generated using this [script](generate_mindmap_image.sh) and is automatically updated at [each push on the main branch](.github/workflows/update-mindmap-image.yml).

# Lab

> Lab is based on [Keycloak](https://www.keycloak.org/getting-started/getting-started-docker) in Docker flavor.

> Default port 8080 is used.

> Base flow init URL is `http://localhost:8080/auth/realms/demo/protocol/openid-connect/auth?client_id=demo&redirect_uri=http://localhost:9500/App.html&state=114d367d-b319-44d0-a8cc-9a08c4a0bffd&response_mode=fragment&response_type=code&scope=openid profile api internal-api&nonce=78a3069c-74e8-4f5b-856a-9d890caabc06&prompt=consent`

## Properties

* Admin console is [here](http://localhost:8080/auth/admin) with creds `admin/admin`.
* Realm is named **demo**.
* An OAuth/OIDC Client is present with name **demo**.
* An sample web client, via the [App.html](App.html) file, is provided (this one is defined into the lab configuration).

The lab configuration export is stored in file [Realm-Export.json](Realm-Export.json), so, you can import it via the *Import* feature. Use this [screen to create a realm](http://localhost:8080/auth/admin/master/console/#/create/realm).

## Run it

> This [video](SetupKeycloakLab.mp4) show the steps to setup the Keycloak lab described below.

1) Open a shell and run the following set of commands to start a web server:

```shell
$ python --version
Python 3.7.5
$ cd [REPO_CLONE_FOLDER]
$ python -m http.server 9500
Serving HTTP on 0.0.0.0 port 9500 (http://0.0.0.0:9500/) ...
```

2) Open a shell and run the following set of commands to start a fresh Keycloak instance:

```shell
$ docker --version
Docker version 20.10.7, build f0df350
$ docker run -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin quay.io/keycloak/keycloak:14.0.0
...
[org.jboss.as] (Controller Boot Thread) WFLYSRV0051: Admin console listening on http://127.0.0.1:9990
```

3) Click [here](http://localhost:8080/auth/admin/master/console/#/create/realm) and import the [lab full demo configuration](Realm-Export.json) to setup the Keycloak instance.

4) Create a user via this [menu](http://localhost:8080/auth/admin/master/console/#/create/user/demo): Just fill the **Username** field and click on the **Save** button.

5) Set the password to the user via the tab **Credentials** (disable the **Temporary** flag).

6) Open this [url](http://localhost:9500/App.html) in a browser to access to the demo Web Client..

7) Lab is ready to be used :sunglasses:

# References

* https://courses.pragmaticwebsecurity.com/courses/introduction-to-oauth-2-0-and-openid-connect
* https://courses.pragmaticwebsecurity.com/bundles/mastering-oauth-oidc 
* https://infosecwriteups.com/oauth-2-0-hacking-simplified-part-2-vulnerabilities-and-mitigation-d01dd6d5fa2c
* https://maxfieldchen.com/posts/2020-05-17-penetration-testers-guide-oauth-2.html
* https://portswigger.net/research/hidden-oauth-attack-vectors
* https://portswigger.net/web-security/oauth
* https://connect2id.com/learn
