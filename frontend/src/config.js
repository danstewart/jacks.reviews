// Config data

const isLocal = !window.localStorage.getItem('forceProd') && window.location.hostname.indexOf('127.0.0.1') != -1;

export const config = {
    endpoint: isLocal ? 'http://127.0.0.1:3000' : 'https://api.jacks.reviews'
}
