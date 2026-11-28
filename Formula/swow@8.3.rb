# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT83 < AbstractPhpExtension
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
    manifest_sha256 "6a40b0bc229f3b03672f3ab54a85a5263772432e4cb582cc297f1ca9976a37f1"
    sha256               arm64_golden_gate: "8a8cad3a6041650bab3a5f699ec4a0356c03fa9b0325c7bb158f6ff884636436"
    sha256               arm64_tahoe:       "2e9164322dceb5bacf2d1e37505fc64387e8affe41646e1b2a31ff5c0c344e71"
    sha256               arm64_sequoia:     "381a18ba25c53dcee764cb4ed5fc0689b37927e76d35edbec7394409ef11eaeb"
    sha256 cellar: :any, arm64_linux:       "b6de44d637f0b29999cbdd062fc89e20b7dd9e17dedc5d61ec04069b64bb2f6d"
    sha256 cellar: :any, x86_64_linux:      "2a28ac49b81cbcd15e52c926cef40a2c9313e2ad15ded6c2155d27dc900c4bdd"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.3", because: "both provide swoole-like coroutine functionality"

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
