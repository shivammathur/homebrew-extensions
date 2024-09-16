# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.29.tar.xz"
  sha256 "288884af60581d4284baba2ace9ca6d646f72facbd3e3c2dd2acc7fe6f903536"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "9ed2b28085db438cffc868b0eca4b5192bfb2913ead757606a55c0710a47f160"
    sha256 cellar: :any,                 arm64_sonoma:   "506b3cde0f85e83602de3ad41175791849a703c030067ed303fa6331b2758fd9"
    sha256 cellar: :any,                 arm64_ventura:  "087d24b9c55c69c4f5993b7c0128a8572d8f19d5e594f3edafee50679513c129"
    sha256 cellar: :any,                 arm64_monterey: "3666fb356ef2be43a93a7fd2cd83f3c5ca154406aa8201512b13ce9a013e1b68"
    sha256 cellar: :any,                 ventura:        "9777d132073abd54556d7dd19dc59405d712332044aa7995c148039028a1cde2"
    sha256 cellar: :any,                 monterey:       "eaf0aeb68617db16ba123ec5444d16b739911b0be21b7aec910cefc5453b6583"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae48bb215e8309cf539a474355580e4519dffe494dffa90956ea2eae22b00a3e"
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
