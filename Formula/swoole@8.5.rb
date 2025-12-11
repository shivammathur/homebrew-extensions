# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT85 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/3944e51fb4d9a9878298b48cc6ca23bd790013b2.tar.gz"
  sha256 "7963db0a9a2e470f1aa162f6fb13209f0c823a34cd08525c441e53e6c60c04c6"
  version "6.1.4"
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f60489b3ac4b5ad32160dd2bd36a25669048c893de063f38fa4bc95b455190f5"
    sha256 cellar: :any,                 arm64_sequoia: "327320fdbb94ba647af1cf567dcd5a2f0a20c32e8ffe4a87d67067466917a1df"
    sha256 cellar: :any,                 arm64_sonoma:  "c60ff94a045a9ed1ef5937e58669d82848cd2b86f111234a20d33d9a22e89d57"
    sha256 cellar: :any,                 sonoma:        "5f1f89bcfb27944c1ab34ad96ea8f49eb2e254437e9067dceab8fcde8de60f2a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6692cfe5784ac8a4df32028ac072ade0217085f5387b288ff084b8439b1f7ee5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f0ca10497904875122030fc1947bf3bc9c8242a63952858e5b446bbb5ceb6113"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --enable-swoole-curl
      --enable-http2
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
