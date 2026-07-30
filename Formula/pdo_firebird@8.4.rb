# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.24.tar.xz"
  sha256 "e127be09a8506f4327c5cfa78a614b00d210714484ec215ce0011b4a03c00731"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1a01e6001cb7f440e38a4fad1834f5dbc0d4573c667b84f9e387a40117f6909e"
    sha256 cellar: :any, arm64_sequoia: "605807ad41c61138f404de770496e7a1d93e84a4ec2bddee7aa8c2239720d387"
    sha256 cellar: :any, arm64_sonoma:  "ae0e9df7d6d582795678dc23131973bc6043431c32edfa6c90c3f1b02a2a7214"
    sha256 cellar: :any, sonoma:        "8ccacef2c6309bc7d1a2153ce40bc4ae04ab78724def371ccb4b030a7fc51695"
    sha256 cellar: :any, arm64_linux:   "6eaef775f1a1db6b31b2f2c662abb1c8f6c6118b6b988b60c8d89a7a8ae094c9"
    sha256 cellar: :any, x86_64_linux:  "7c45ed08f9ee1a533cd4ed46ba6427476608785f6fe510bf5160df1a76f5fb05"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
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
