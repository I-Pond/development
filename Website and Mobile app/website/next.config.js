/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    appDir: true,
  },
  images: {
    domains: ["unsplash.com", "images.unsplash.com"],
  },
  reactStrictMode: true,
};

module.exports = nextConfig;
