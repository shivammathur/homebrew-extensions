# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT83 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  revision 1
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256               arm64_golden_gate: "8302add424af4533fcd91d07ef320ce132aced2e66116fc3d83675187b6d586b"
    sha256               arm64_tahoe:       "b87702f494e4e54f6f501dc6e67a8d66c7ec40fa2ee7ee0e32874195a6844aca"
    sha256               arm64_sequoia:     "1946eaf3369f8833e79ed1d06544229234df9ecd6f4c128d1705b9032637e49a"
    sha256 cellar: :any, arm64_linux:       "609bcc3e097c7803fa7de40fce9a9fef30cb61b741cb86ad8504a50fb1a419a8"
    sha256 cellar: :any, x86_64_linux:      "ca29417bec53656da09fd958f1e38a44f655abf531fbc1414b67cdffe29ff67c"
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
