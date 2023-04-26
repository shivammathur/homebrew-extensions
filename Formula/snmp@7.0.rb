# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/06ccc60e1bd15158ae2047c7e9a151516dfec7c0.tar.gz"
  version "7.0.33"
  sha256 "3115b7d37e6e48c1924c243f79a335ad9c9df770f8b862d2a9536a2cee5d65ff"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "3d5dc5fa907c8c0911b1a088722f8ca2409601602c09022072379bd24ca026c9"
    sha256 cellar: :any,                 arm64_big_sur:  "1a65ce1d311f0d8ceb6c33811e4d41941acb2cf8dfcb2cac9e9ba4bb13cd1a7b"
    sha256 cellar: :any,                 ventura:        "cb4ed771f5bbab3afe1cc7c0bdb82a588edda7b6f0849e973bf19429cfe1bd0e"
    sha256 cellar: :any,                 monterey:       "1138b5238f847c61abfb14f7e2dcaf58a7569bb23088be4eb394d63540d44498"
    sha256 cellar: :any,                 big_sur:        "974634f0501ae89387e46492b5b0be84edac66c78f871ef6d73ecfe818ebf81c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fb130bedb3eaabb99b6e3f1c5830f35827c45b50937941ce4946dd803fd17741"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
