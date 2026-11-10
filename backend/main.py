from fastapi import FastAPI

app = FastAPI(title="Gaspar Saúde Território - API Demo", version="0.1.0")

# Apenas exemplos inventados; não conectar a base de produção do PEC.
FAMILIAS = [
    {"id": "demo-001", "responsavel": "Família Exemplo A", "microarea": "07", "domicilio": "Rua das Flores, 10", "pendencias": 2},
    {"id": "demo-002", "responsavel": "Família Exemplo B", "microarea": "07", "domicilio": "Rua do Sol, 25", "pendencias": 0},
    {"id": "demo-003", "responsavel": "Família Exemplo C", "microarea": "07", "domicilio": "Praça Modelo, 3", "pendencias": 1},
]


@app.get("/health")
def health():
    return {"status": "ok", "ambiente": "demonstracao", "pec_conectado": False}


@app.get("/api/v1/familias")
def listar_familias():
    return {"items": FAMILIAS, "total": len(FAMILIAS), "demo": True}
