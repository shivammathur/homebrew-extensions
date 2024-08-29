# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8aaedbf96f87770867f77ce6846e0e3fbda8265e.tar.gz?commit=8aaedbf96f87770867f77ce6846e0e3fbda8265e"
  version "8.4.0"
  sha256 "89b6c87edcf2b0020df0993d7dd9bdb461ac05b04c92e865fa0f3307763434fb"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 57
    sha256 cellar: :any,                 arm64_sonoma:   "284090ef58530b589b1060ce705572aa256ec8aef27a136d27560e83073d2fb8"
    sha256 cellar: :any,                 arm64_ventura:  "be25ba3f7f39332103e612a3e748a307c8f41402463df2226824efe698c9fdde"
    sha256 cellar: :any,                 arm64_monterey: "b45c69248458627e6d35be0c61fdabcbf6f53c18ce080fabc88b24ea1e044319"
    sha256 cellar: :any,                 ventura:        "4b8a13d25aa5d805896fce86f8719a0cfb13e3fb1ed138dadea2bc15d8194e84"
    sha256 cellar: :any,                 monterey:       "020daadeeb793ae729269cb28f27bee2d81b4ab6990d2d8c973a3d5ac12dc66c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae61350fd582f4d1c2e4e3b903913dcb37b7164141556b4a6fb157a2be68ae8f"
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
