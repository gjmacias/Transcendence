declare global {
    interface Window {
      handleCredentialResponse: (res: any) => void;
    }
  }
  
  window.handleCredentialResponse = async (response) => {
    console.log("Token de Google:", response.credential);
  
    // Aquí llamarías a tu backend Node para validar token
    const r = await fetch("http://node-auth:4000/verify", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ token: response.credential })
    });
  
    const result = await r.json();
    console.log("Respuesta del backend:", result);
  };
  