# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e22d5715bb4828a583510b0a740114b1b298a128a5cd007b7c3cc4dd5deff4c1"
    sha256 cellar: :any,                 arm64_sequoia: "4b5e37b673b71194b12229d6ca7cde9335789a7c425a43d680693c8dfbcc4f10"
    sha256 cellar: :any,                 arm64_sonoma:  "3c4a741bd38b922de94d0175daae9460605e107fd207989d789193e486d0da0b"
    sha256 cellar: :any,                 sonoma:        "4788a3bc2b342e0432887734835f51acb28d90d7f65c3df5a3814a9928823e39"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5ed9f0eb8f92bb518467ac407280eaf7b7a82ca5975e6fde801320cf63743608"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c02ef31abdaaa3eb1e3ac11e22b31f0cd69d90fc61f7e4857a117d5ba046bdb7"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.19.tar.xz"
  sha256 "11f7164ab26d356c31f94d3d69cc0e0707d5d2d6494a221aaeae307c08eaaa1c"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
