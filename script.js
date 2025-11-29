async function processar() {
    let foto = document.getElementById("foto").files[0];

    if (!foto) {
        alert("Envie uma foto primeiro");
        return;
    }

    document.getElementById("resultado").innerHTML =
        "<p>Reconstruindo fragmento... Aguarde...</p>";

    // converter imagem para base64
    let reader = new FileReader();
    reader.readAsDataURL(foto);
    reader.onload = async function() {
        let imagemBase64 = reader.result;

        // simulação de IA real
        let resposta = await fakeIA(imagemBase64);

        document.getElementById("resultado").innerHTML = `
            <h3>Reconstrução 3D Gerada</h3>
            <img src="${resposta}" style="width:300px;">
            <p>Modelo gerado automaticamente.</p>
        `;
    };
}

// IA falsa por enquanto (depois coloco a verdadeira)
async function fakeIA(img) {
    return "https://i.imgur.com/6o5V4HF.png"; // imagem fake só para mostrar
}
