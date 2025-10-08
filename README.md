## 🚀 How to Run This Project

### 🧰 Prerequisites

Make sure you have the following before getting started:

* **VS Code** (or any IDE of your choice)
* **At least 2–3 GB of free storage space**
* **Internet connection** (optional, but recommended)

---

### 🖥️ Setting Up WSL (Windows Subsystem for Linux)

> **Note:** These instructions are for users on **Windows** without WSL or Ubuntu installed.

1. Open **Windows Search**, type **PowerShell**, and **Run as Administrator**.
2. Install Ubuntu 24.04 by running:

   ```bash
   wsl --install --distribution Ubuntu-24.04
   ```

---

### 🧱 Setting Up Dependencies

Once inside Ubuntu (WSL terminal), run the following commands:

```bash
sudo apt update
sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev -y
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
mise use -g ruby@3
```

#### ✅ Verify Ruby Installation

```bash
ruby --version
```

---

### ⚙️ Installing Rails

Install Rails using:

```bash
gem install rails
```

Then verify:

```bash
rails --version
```

---

### 📂 Cloning the Repository

1. Open **VS Code** (or your preferred IDE).
2. Clone this repository:

   ```bash
   git clone <REPOSITORY_URL>
   ```
3. Move the cloned folder to:

   ```
   \\wsl.localhost\Ubuntu-24.04\home\<USER>\
   ```
4. If prompted for permission, **allow access**.

---

### 🧩 Setting Up the Project

1. In VS Code (or your IDE), open the integrated terminal.
2. Make sure the terminal is set to **WSL / Ubuntu-24.04**.
3. Navigate to the project folder:

   ```bash
   cd ~/project-folder-name
   ```
4. Install required gems:

   ```bash
   bundle install
   ```

---

### 🗃️ Database Setup

Run the following commands to set up your database:

```bash
rails db:migrate
rails db:seed
```

If you encounter a **permission denied** error for these commands, make the scripts executable first:

```bash
chmod +x bin/rails
chmod +x bin/rake
```

Then try again:

```bash
rails db:migrate
rails db:seed
```

---

### ▶️ Running the Application

Start the development server:

```bash
bin/dev
```

If it gives you an **access denied** error, run:

```bash
chmod +x bin/dev
```

Then start it again:

```bash
bin/dev
```

If everything goes smoothly, the project should now be running locally 🎉
