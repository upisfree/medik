# medic
Manage your Windows apps from command line. Useful for automation or if you afraid GUI.

## Usage
#### Update an app
```bash
medic update --id="APP_ID"
```

#### Print app list
```bash
medic list
```

#### Restore medic to defaults
```bash
medic reset
```

#### Help
```bash
medic help
```

## Install
```bash
sudo npm install medic -g
```

## Build
```bash
npm install
gulp # dev
gulp min # production
```