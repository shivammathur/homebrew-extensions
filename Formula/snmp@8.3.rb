# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.30.tar.xz"
  sha256 "67f084d36852daab6809561a7c8023d130ca07fc6af8fb040684dd1414934d48"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ce977c43a9b6aa47dfe371bff9267f312db50149ee848c3e31a5b6cc08bde890"
    sha256 cellar: :any,                 arm64_sequoia: "9ea3dff35fab8ead471783081f7523ef4172c1e110d4e043b959d3318f2b6d73"
    sha256 cellar: :any,                 arm64_sonoma:  "a662447937c6f90fdc52fd0ddcdcd1723bec8ef3df5f8b941273f09ab2aa364e"
    sha256 cellar: :any,                 sonoma:        "3a0d709f1a6fec70e5dcb07c340704eb0f2f7b305f219c1faccaea3ebb50fb55"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0ab9f40f2972ad20969d1a1ada9aecf0c5b051de31c4a9bedd632370f34689dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "013e0b8f04ca2f0b416dc7af015f679d8ff5850678c984d94998cf15ef07a6ce"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
