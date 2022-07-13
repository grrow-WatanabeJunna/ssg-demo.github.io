
```sh
git checkout main
yarn dev
yarn build
git add -A
git commit -m "update content"
git checkout gh-pages
cp -R out/* ./
./_pre-process.sh
open index.html
git add -A
git commit -m "update bundle"
git push origin gh-pages
```