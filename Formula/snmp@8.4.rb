# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2fe05c89806f16acd6948f3a8d72878d37d1bc23.tar.gz?commit=2fe05c89806f16acd6948f3a8d72878d37d1bc23"
  version "8.4.0"
  sha256 "c535169f6bf31017b89b15fd2e75d56e08d5911ca3340262e9ebaf696b25dab7"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_sonoma:   "a483621f6364e162e21c7677658e2959b5338ca75cfe09fcd7c6df59dd06db4c"
    sha256 cellar: :any,                 arm64_ventura:  "e9b17da88153c9a733d1a1ea5bb909a5d243f884fcef451543df66ae9a4f7c2f"
    sha256 cellar: :any,                 arm64_monterey: "a7a3caff562e63744db1fa1046175ccae60cd148e03f038764f5aa79b475f78e"
    sha256 cellar: :any,                 ventura:        "da29c74819e609934ef9bfed5b78fe78f1f5254d546cb4c7ca7971d8edf621a0"
    sha256 cellar: :any,                 monterey:       "9a5989df293c80e0c2d8fff5214b192db6f48db13583486926d962567e562a93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2d21b4c9c30cd41f208904c11fc4720a061c627ed62be0bfb2a7b94bc7392900"
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
