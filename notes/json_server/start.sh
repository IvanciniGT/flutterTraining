
npm install -g json-server
json-server --watch db.json --host 172.31.0.112 --port 8080

# CReate a new npm project
npm init # on any folder
npm install json-server
package.json <- script
      "scripts": {
        "start-backend": "json-server --watch db.json --host 172.31.0.112 --port 8080"
      },
npm run start-backend

# That requires node