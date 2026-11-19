# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.37.tar.xz"
  sha256 "0237af84478b7a7649d3964153f1b8653d622550b846f56d63062de683fb86bb"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6b27760540fc10472636a95cb38734d44579a275604176905e82e9a5e56dc9dd"
    sha256 cellar: :any, arm64_tahoe:       "18475e7fa18247dda59bad8bcd7c454c70d7a9221a98f4771b0ddf632c7e16e6"
    sha256 cellar: :any, arm64_sequoia:     "faebf56c4194853b41c8f67eaa4ea064b2d4eaadbd92f2341250c313ebf56762"
    sha256 cellar: :any, arm64_linux:       "9e25f69d96a8b477f70cbb1f051af7d57142f84df629bf555fd08447393fd2fc"
    sha256 cellar: :any, x86_64_linux:      "a1245d92a4bef8c9f1766ae626b85940c528d0bd63af5c5075682e11b7a753bf"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
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
