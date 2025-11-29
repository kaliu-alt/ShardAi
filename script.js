async function processar() {
    let foto = document.getElementById("foto").files[0];

    if (!foto) {
        alert("Envie uma foto primeiro");
        return;
    }

    document.getElementById("resultado").innerHTML =
        "<p>Reconstruindo fragmento... Aguarde...</p>";

    let reader = new FileReader();
    reader.readAsDataURL(foto);

    reader.onload = async function() {
        let imagemBase64 = reader.result;

        // IA fake por enquanto
        let resposta = await fakeIA(imagemBase64);

        document.getElementById("resultado").innerHTML = `
            <h3>Reconstrução 3D</h3>
            <img src="${resposta.imagem}" style="width:300px;">
            <p>Material: ${resposta.material}</p>
            <p>Idade aproximada: ${resposta.idade}</p>
            <p>Origem provável: ${resposta.origem}</p>
        `;
    };
}

async function fakeIA(img) {
    return {
        imagem: "https://i.imgur.com/6o5V4HF.png",
        material: "cerâmica",
        idade: "entre 800 e 1200 anos",
        origem: "América do Sul"
    };
}
