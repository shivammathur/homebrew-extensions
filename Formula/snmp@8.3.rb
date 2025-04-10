# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.20.tar.xz"
  sha256 "f15914e071b5bddaf1475b5f2ba68107e8b8846655f9e89690fb7cd410b0db6c"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d2af9f5d4e38243a3a0e0350433dd248e6e559065f342fb50de3af4b5131baa6"
    sha256 cellar: :any,                 arm64_sonoma:  "ecc540802abaac017b154a89f4d06cc966eee0a50cb0110bd3ef16c7b7992d26"
    sha256 cellar: :any,                 arm64_ventura: "879a5fa339268110696dabbe6a1579a0556ec8470e454d96f0eea7c14ac3fab1"
    sha256 cellar: :any,                 ventura:       "258b0d0aac62f8c633c1261c125cc5ac3bf7d7a86789029ad45636e8450917f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03f3813bd880f2c9c5c90caf0dcd0b67d2b3598d56965304240bb8cbf226b1bc"
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
