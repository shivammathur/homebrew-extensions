# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT80 < AbstractPhpExtension
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
    manifest_sha256 "b949297dd4320af03bb79ead17fb5280c00d722462e23d3016535cff1737d83e"
    sha256               arm64_golden_gate: "f0c95d7cee60ee96ebcb98ae14af2c5724989f1530bc2e04ee07901af9abf831"
    sha256               arm64_tahoe:       "14fe21ede9bfef92fc23bbb92a6109e8bd2c684ed7e12afd50c9f9fa290890a2"
    sha256               arm64_sequoia:     "1f7081a88d68cf07ddddd7edf022ab1814623bfbea284131aab531f92c97f2aa"
    sha256 cellar: :any, arm64_linux:       "6ea4fb6453d654adc2b8de565c3f6c803feb21d753ac1fad2b8474bcfb6ac700"
    sha256 cellar: :any, x86_64_linux:      "958aa4bf5d1128d86103238276d41139e1f4f20dece4209fdd4fb70827dc2265"
  end

  depends_on "openssl@4"
  depends_on "libpq"

  uses_from_macos "curl"

  conflicts_with "swoole@8.0", because: "both provide swoole-like coroutine functionality"

  def install
    args = %w[
      --enable-swow
      --enable-swow-ssl
      --enable-swow-curl
      --enable-swow-pdo-pgsql
    ]
    Dir.chdir "ext"
    inreplace %w[src/swow_stream.c src/swow_ssl.c],
              /ZSTR_INIT_LITERAL\(("[^"]*"),/, 'zend_string_init(ZEND_STRL(\1),'
    inreplace "src/swow_closure.c", "ZEND_BIND_EXPLICIT | ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
