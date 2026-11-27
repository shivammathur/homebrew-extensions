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
    manifest_sha256 "39bdc8c028c619fb512e0b812d1cbadd551894514466ef450c117a26a5076ca9"
    sha256               arm64_golden_gate: "2057ac2420eefc2703c7b86308aa9ea6a0b9ad0a76a5d45bec84d16ee31240a1"
    sha256               arm64_tahoe:       "22d046806d1d4d6fe6ce8cea89708d19e9497c4cac773ff374cdfcec7cf58b2b"
    sha256               arm64_sequoia:     "2e42db2e97bf316426a45334ab07f574df77b06804ee0ca7f58920f357c5f9e0"
    sha256 cellar: :any, arm64_linux:       "c292a6379be59f886d2d7cfec28e89953b6424553f5cda7380a30adb68f1b311"
    sha256 cellar: :any, x86_64_linux:      "2fb62cf266def03f3e54cb7252ed1d6feab0b4a463d38e5ff8cb117f0cc96056"
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
