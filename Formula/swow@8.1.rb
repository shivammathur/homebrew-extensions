# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT81 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "f8c702170e1f1deb9716e4fb86f69d9c07e3d73958ae2d79544a234443ade651"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "4e1d5ff9ce3e0efbb3ceef5743a54ad31edc09b6659dabf19e16fd625d3e4734"
    sha256               arm64_golden_gate: "56ee9850661b3952604d60c31a9ee211e539165910cb40d109b3ec149b8092fc"
    sha256               arm64_tahoe:       "7be18026fbe283cc0bf1f67e3daabcf44155d6e50e3ec8c9c92c0e16df464503"
    sha256               arm64_sequoia:     "978086999e6a5f8fbeafa7ba261baf6d9b50500953191c410a10b132eb373add"
    sha256 cellar: :any, arm64_linux:       "d8333bf4e7f53354cadc2216be602fc430d0aa9a6e0db4f4a2229d0edf679136"
    sha256 cellar: :any, x86_64_linux:      "4e308cc6c045190fdbe39db747f0ebfd8b6b51ea3b394755846d1985ca6d6939"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.1", because: "both provide swoole-like coroutine functionality"

  def install
    args = %w[
      --enable-swow
      --enable-swow-ssl
      --enable-swow-curl
      --enable-swow-pdo-pgsql
    ]
    Dir.chdir "ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
