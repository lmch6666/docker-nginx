const http = require('http');
const fs = require('fs')

const app = http.createServer((req, res) => res.end('hello'))
  const filesize = fs.statSync('./index.html').size  //获取文件信息
  app.listen(3000, () => {
    console.log('Listening 3000')
  })