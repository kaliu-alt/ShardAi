// frontend logic
document.getElementById("btnAnalyze").addEventListener("click", async ()=>{
  const f = document.getElementById("singleFile").files[0];
  if (!f) return alert("Escolha uma imagem para analisar.");
  const form = new FormData();
  form.append("image", f);
  document.getElementById("analysisResult").textContent = "Analisando...";
  try {
    const r = await fetch("/api/analyze", { method:"POST", body: form });
    const j = await r.json();
    if (j.error) { document.getElementById("analysisResult").textContent = "Erro: " + j.error; return; }
    if (j.result) {
      document.getElementById("analysisResult").textContent = JSON.stringify(j.result, null, 2);
    } else if (j.raw) {
      document.getElementById("analysisResult").textContent = j.raw;
    } else {
      document.getElementById("analysisResult").textContent = JSON.stringify(j, null, 2);
    }
  } catch (err) {
    document.getElementById("analysisResult").textContent = "Erro na requisição: " + err.message;
  }
});

document.getElementById("btnReconstruct").addEventListener("click", async ()=>{
  const files = document.getElementById("multiFiles").files;
  if (!files.length) return alert("Escolha várias fotos para reconstrução.");
  const form = new FormData();
  for (let i=0;i<files.length;i++) form.append("photos", files[i], files[i].name);
  document.getElementById("reconStatus").textContent = "Enviando fotos para reconstrução 3D...";
  try {
    const r = await fetch("/api/reconstruct", { method:"POST", body: form });
    const j = await r.json();
    if (j.error) { document.getElementById("reconStatus").textContent = "Erro: " + JSON.stringify(j.error); return; }
    // espera que o serviço retorne { model_url: "https://..." }
    if (j.model_url) {
      const mv = document.getElementById("modelViewer");
      mv.src = j.model_url;
      mv.style.display = "block";
      document.getElementById("reconStatus").textContent = "Modelo pronto. Use o viewer abaixo.";
    } else {
      document.getElementById("reconStatus").textContent = "Resposta: " + JSON.stringify(j);
    }
  } catch (err) {
    document.getElementById("reconStatus").textContent = "Erro: " + err.message;
  }
});
