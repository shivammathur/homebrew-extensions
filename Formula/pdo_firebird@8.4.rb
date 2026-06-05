# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.22.tar.xz"
  sha256 "696c0f6ad92e94c59059c1eb6e300842b8d050934226efcdf00f2a413cb083cf"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ab0b9a9084c85546147ffde864711de31f42be9d82a10af760f472479ae8ec10"
    sha256 cellar: :any, arm64_sequoia: "8e5f470b60a7224b2b270c3c91f816b947b91492db07a3f2fe1289b045229a64"
    sha256 cellar: :any, arm64_sonoma:  "8d1354507c67d6bbaa4efabc2699b9f8339ee6880d448a863e3d0e08456830cc"
    sha256 cellar: :any, sonoma:        "25f24b3955d7df384ef029375aff687acd6099196ba01d0483379841ac0c9d42"
    sha256 cellar: :any, arm64_linux:   "d9e8754f1d6fe83a359ab06380f9f0a4f0e2f9ce2d20f477e9b2c433a65da85c"
    sha256 cellar: :any, x86_64_linux:  "769fe35ff9ffb2269ed443227b0fff28d30e4aaf3926b85db9a91a323e47d197"
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
