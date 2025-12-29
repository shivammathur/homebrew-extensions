# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swow Extension
class SwowAT80 < AbstractPhpExtension
  init
  desc "Concurrent coroutine network communication engine"
  homepage "https://github.com/swow/swow"
  url "https://github.com/swow/swow/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "4939bb0390ad95861e7f98c279df41a7a00ca21fc94383be812a5163d63598e7"
  head "https://github.com/swow/swow.git", branch: "develop"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "5f6833fd767ef367ae05073a555a07d4bcd3757c5921fc7fcc1ab62afba44c11"
    sha256                               arm64_sequoia: "93975c342029b9cfde432620c0c7a6c90a42b8aeb2fed42a4050325cb833be31"
    sha256                               arm64_sonoma:  "d6025cdf7dc3c5546c7fecf67c8a33b512585e292ff6b0a5efba3b7f3a67382c"
    sha256 cellar: :any,                 sonoma:        "613b0de3eaf240f46028a61d1cae41f64a0b9ac07d92dcde0a06c2c265aa42d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "54fd6f94e024e932abedb20cea257d823d07e65396537669e0359a15fbe9aa63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "52c37c00bd8ed025f57d02a9b53b00df3ca863d4bb9e2e50cdc0173901187626"
  end

  depends_on "openssl@3"
  depends_on "libpq"

  conflicts_with "swoole@8.0", because: "both provide swoole-like coroutine functionality"

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
