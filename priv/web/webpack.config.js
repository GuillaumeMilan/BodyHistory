const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = [
  {
    mode: "development",
    entry: './js/index.js',
    output: {
      filename: 'main.js',
      path: path.resolve(__dirname, 'dist'),
    },
    plugins: [new MiniCssExtractPlugin()],
    module: {
      rules: [
        { test: /\.css$/,
          use: [MiniCssExtractPlugin.loader, 'css-loader']
        },
        {
          test: /js\/.*\.js$/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-react'],
            }
          }
        }
      ]
    }
  },
];
