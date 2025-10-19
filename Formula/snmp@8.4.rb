# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.12.tar.xz"
  sha256 "c1b7978cbb5054eed6c749bde4444afc16a3f2268101fb70a7d5d9b1083b12ad"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b673627235b3e7f696c7e15da8846315c85763400118be3435579c408b0c5f47"
    sha256 cellar: :any,                 arm64_sonoma:  "3acda214cab5dcb00cf2c90e409b2614c80089f420f13efbf826044ea33c3b9a"
    sha256 cellar: :any,                 arm64_ventura: "51c845cfcc76c2ca6c4b9b265ad9d621d22d4b9df65b20bf4318833e363fe895"
    sha256 cellar: :any,                 sonoma:        "09f2d194339d840041923aa9f3e99b38884f2bd6af575b66ed9e2fd8a3f474a0"
    sha256 cellar: :any,                 ventura:       "8507009aee1b313e2640752c3c0ba9ded6ea7acbc29c6c15a5411beb63b81374"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5c8fa69f2a7edb3921aaabb73f9d076667db6a2f0edcea3d71829958502b3038"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "896681641bfd2cf750a57560e809e87b95f2532c7c77a545bb2f27dd51ce0420"
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
