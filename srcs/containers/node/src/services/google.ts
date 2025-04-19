import { OAuth2Client } from "google-auth-library";
const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);

export async function verifyGoogleToken(idToken: string) {
  try {
    const ticket = await client.verifyIdToken({
      idToken,
      audience: process.env.GOOGLE_CLIENT_ID,
    });
    const payload = ticket.getPayload();
    return {
      sub: payload?.sub,
      email: payload?.email,
      name: payload?.name,
      picture: payload?.picture,
    };
  } catch (error) {
    console.error("❌ Token inválido", error);
    return null;
  }
}
