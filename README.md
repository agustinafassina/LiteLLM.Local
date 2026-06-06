# 🤖 LiteLLM Local 🦙🐳
Local [LiteLLM](https://docs.litellm.ai/) proxy that exposes an OpenAI-compatible API and routes requests to [Ollama](https://ollama.com/) models on your machine.

Useful for tools that speak the OpenAI protocol (Cursor, scripts, HTTP clients) while pointing at local models instead of the cloud.

## 📋 Requirements
- [Docker](https://www.docker.com/) and Docker Compose
- [Ollama](https://ollama.com/) running on the host (port `11434`)
- Model pulled in Ollama, for example: `ollama pull phi3:mini`

## ⚙️ Configuration
The `config.yaml` file defines the exposed model and the Ollama connection:

| Parameter  | Default value                       |
|------------|-------------------------------------|
| API model  | `llama3-local`                      |
| Backend    | `ollama/phi3:mini`                  |
| Ollama URL | `http://host.docker.internal:11434` |
| Master key | `sk-1234`                           |
| Port       | `4000`                              |

Edit `config.yaml` to change the model, API key, or Ollama URL.

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

The script sends a message to `http://localhost:4000/v1/chat/completions` using the `llama3-local` model.

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