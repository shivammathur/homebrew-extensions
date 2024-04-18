# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3df78fd9f89e8356b78353e133fc05a6101b7237.tar.gz"
  sha256 "4a6a9f30a9652f6d44df10c994fc640e48a9744ab91a0ceb990a19d2cd88e1a3"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8aa04c1934d793de2e460ddee5dd8c17d6332b2009f0cbeb6ac92a6794e169fd"
    sha256 cellar: :any,                 arm64_ventura:  "f4fa1ffb0f4068500924bd014474c68a235243ca4ac35f3f84ce92bbc3593c5e"
    sha256 cellar: :any,                 arm64_monterey: "b80d195c06f533d899dacce1bea4c3b49172b33bcbc6e8c19eb924298562765a"
    sha256 cellar: :any,                 ventura:        "a329048c7900b2907fbb3fd338edfb3be07c4e392de7e4cefa532d886abe24c6"
    sha256 cellar: :any,                 monterey:       "ff0de49aab27a3f568e1cc7c27c7801d316c9a5d569c4fd703d4b75132d76545"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b3a89722a819cc6d197e1ed98029bede209db23c8bda8d64f6d7441f559ea2e"
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
