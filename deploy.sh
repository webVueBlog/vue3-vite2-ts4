set -e

yarn build
printf "打包成功\n"

cd dist

git init
git checkout -b dist
git add -A
git commit -m 'deploy'
printf "本地提交成功\n"
# 覆盖式地将本地仓库发布至github，因为发布不需要保留历史记录
# 格式为：git push -f git@github.com:'用户名'/'仓库名'.git master
git push -f https://github.com/webVueBlog/vue3-vite2-ts4.git dist

printf "dist目录上传成功\n"
