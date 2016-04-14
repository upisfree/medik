# medik
Manage your Windows apps from command line. Useful for automation or if you afraid GUI.

**Very early development version. May not work, may not stable. Use on your own risk. Please.**

Wanna help? Any questions? Open issuse or write to me: [upisfree@outlook.com](mailto:upisfree@outlook.com).

## Usage
#### Update an app
```bash
medik update --json="JSON_PATH"
```

#### Print app list
```bash
medik list
```

#### Restore medik to defaults
```bash
medik reset
```

#### Help
```bash
medik help
```

## Install
```bash
sudo npm install medik -g
```

## Build
```bash
npm install
gulp
```

### Little bit about headless usage
[Here!](https://github.com/segmentio/nightmare/issues/534)