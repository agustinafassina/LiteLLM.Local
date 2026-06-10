# 🤖 LiteLLM Local 🦙🐳
Local [LiteLLM](https://docs.litellm.ai/) proxy that exposes an OpenAI-compatible API and routes requests to [Ollama](https://ollama.com/) models on your machine.

Useful for tools that speak the OpenAI protocol (Cursor, scripts, HTTP clients) while pointing at local models instead of the cloud.

## 📋 Requirements
- [Docker](https://www.docker.com/) and Docker Compose
- [Ollama](https://ollama.com/) running on the host (port `11434`)
- At least one model pulled in Ollama:

```bash
ollama pull phi3:mini
ollama pull llama3.2:1b
ollama pull qwen2.5:1.5b
ollama pull gemma2:2b
```

## ⚙️ Configuration
The `config.yaml` file defines the exposed models and the Ollama connection.

### Available models

| API model             | Ollama backend        | Notes                          |
|-----------------------|-----------------------|--------------------------------|
| `llama3-local`        | `phi3:mini`           | Compact, good general use      |
| `llama3.2-1b-local`   | `llama3.2:1b`         | Very lightweight Meta model    |
| `qwen2.5-1.5b-local`  | `qwen2.5:1.5b`        | Strong quality for its size    |
| `gemma2-2b-local`     | `gemma2:2b`           | Balanced speed and quality     |

Use the **API model** name in requests (e.g. `"model": "qwen2.5-1.5b-local"`).

### General settings

| Parameter  | Default value                       |
|------------|-------------------------------------|
| Ollama URL | `http://host.docker.internal:11434` |
| Master key | Set in `config.yaml`                |
| Port       | `4000`                              |

Edit `config.yaml` to add models, change the API key, or update the Ollama URL. Restart the proxy after changes:

```bash
docker compose restart litellm
```

## 🛠️ Commands
### ▶️ Start the proxy
```bash
docker-compose up -d
```

### 📜 View logs
```bash
docker-compose logs -f litellm
```

### ⏹️ Stop the proxy
```bash
docker-compose down
```

### 💬 Test a chat request (PowerShell)
With the proxy and Ollama running:

```powershell
.\chat-try.ps1
```

The script sends a message to `http://localhost:4000/v1/chat/completions`. Change the `model` field in `chat-try.ps1` to use any available API model.

### 🌐 Test with curl
```bash
curl http://localhost:4000/v1/chat/completions \
  -H "Authorization: Bearer sk-1234" \
  -H "Content-Type: application/json" \
  -d "{\"model\": \"llama3-local\", \"messages\": [{\"role\": \"user\", \"content\": \"Hello\"}]}"
```

## 📁 Repository structure
| File               | Description                              |
|--------------------|------------------------------------------|
| `docker-compose.yml` | Runs the LiteLLM container             |
| `config.yaml`        | Models, master key, and LiteLLM settings |
| `Dockerfile`         | Alternative image (manual build)         |
| `chat-try.ps1`       | Test script for Windows PowerShell       |