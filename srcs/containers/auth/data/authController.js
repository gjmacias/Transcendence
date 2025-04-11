import axios from 'axios'; // Axios is a promise-based HTTP client for the browser and Node.js

const authController = {
	login: (req, res) => {
		const redirectUrl =
			`https://api.intra.42.fr/oauth/authorize?` +
			`client_id=${process.env.CLIENT_ID}` +
			`&redirect_uri=${process.env.REDIRECT_URI}` +
			`&response_type=code`;
		res.redirect(redirectUrl);
	},

	callback: async (req, res) => {
		const { code } = req.query;
		try {
			const tokenRes = await axios.post('https://api.intra.42.fr/oauth/token', {
				grant_type: 'authorization_code',
				client_id: process.env.CLIENT_ID,
				client_secret: process.env.CLIENT_SECRET,
				code,
				redirect_uri: process.env.REDIRECT_URI,
			});

			const userRes = await axios.get('https://api.intra.42.fr/v2/me', {
				headers: {
					Authorization: `Bearer ${tokenRes.data.access_token}`,
				},
			});

			res.json(userRes.data); // TEMP: show 42 user data

		} catch (err) {
			res.status(500).json({ error: err.message });
		}
	},
};

export default authController;