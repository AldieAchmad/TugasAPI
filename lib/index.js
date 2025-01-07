const axios = require('axios');

const apiKey = '76e0f5d15emshbd806fda54da134p165853jsnba436aea8bce';  // Ganti dengan kunci API Anda
const url = 'https://jokeapi-v2.p.rapidapi.com/joke/Any';

// Fungsi untuk mengambil joke dari API
async function fetchJoke() {
  try {
    const response = await axios.get(url, {
      headers: {
        'X-RapidAPI-Host': 'jokeapi-v2.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey
      }
    });

    const joke = response.data;
    let jokeText = '';
    if (joke.type === 'single') {
      jokeText = joke.joke;
    } else {
      jokeText = `${joke.setup} - ${joke.delivery}`;
    }

    // Tampilkan joke di halaman
    document.getElementById('joke').innerText = jokeText;
  } catch (error) {
    console.error('Error fetching joke:', error);
  }
}

fetchJoke();
