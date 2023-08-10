# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.9.tar.xz"
  sha256 "1e6cb77f997613864ab3127fbfc6a8c7fdaa89a95e8ed6167617b913b4de4765"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e6664d866bea4b45b514c45c0f9da66c119e352f09b208701dcd17b51ab2be84"
    sha256 cellar: :any,                 arm64_big_sur:  "3baad48d83121296a99660c692e0b27a01002f4b1b3331d6768fcc5f7c1274ec"
    sha256 cellar: :any,                 ventura:        "115d5f08a2efd39f441da3d971fcfa60c710b7bed60c9c0b471fab0b600861e4"
    sha256 cellar: :any,                 monterey:       "4dffb6467de8674d613393b8de788c7431e8738c4c6bea2dc077fd9af829e9ac"
    sha256 cellar: :any,                 big_sur:        "60d4768d89908948dde5c112a20381283d50f4b50fd8219738c0a9a1bccd8984"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2df4a0bdf307581e569e93545d66c53a981f557a50a946f58ef2844d37935a9d"
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
