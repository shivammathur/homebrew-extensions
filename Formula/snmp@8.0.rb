# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6bcf470af46ebdfe52ab9ec06920715a02045fa6.tar.gz"
  sha256 "651d5cbc9dfe5837223379c9c7a67bfb6f7c0254b1624f78e3e274fce93d68c6"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "954b2e5e8866aaf16b1e8870bdc6d05f9a81612353eb9b5a4fff40bd566e1364"
    sha256 cellar: :any,                 arm64_ventura:  "81bfdc8ba2b17bfec762d35d37e514ac2721c167b76b287c1063848bb89880af"
    sha256 cellar: :any,                 arm64_monterey: "229dba4a4169e3048b6e80b9d2daf772e0459e952a8d47becb09f376264b0ba4"
    sha256 cellar: :any,                 ventura:        "a2359f56efcd136d9a57c13f6e71c8a08fca85765675414e2cd57eac5947f101"
    sha256 cellar: :any,                 monterey:       "740411ddae2374137cd32d6030c78471c9423131d3c3857f59ad4389d507e55a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2106c269180cc9486e06be1c8cd6690dca29a51336c2ea2fb5b040429eaa2494"
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
