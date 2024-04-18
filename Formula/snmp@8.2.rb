# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.18.tar.xz"
  sha256 "44b306fc021e56441f691da6c3108788bd9e450f293b3bc70fcd64b08dd41a50"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6f48e01f64351c97185fbd99ae02c92becb9659a3813e9fd5865b2394a46c3bd"
    sha256 cellar: :any,                 arm64_ventura:  "05606077e9f60d3fefe4d28fe89e4c6681b9359f804d8d4846e107a7b8ecca3b"
    sha256 cellar: :any,                 arm64_monterey: "30dee535f2630565d4b4c9351044efc637b6d5cb995856945340ebd79e79bc93"
    sha256 cellar: :any,                 ventura:        "5bb4119af638ad9074a1d1430edb6bd7c374a30f2cdcb1c2a6afdae0667b882f"
    sha256 cellar: :any,                 monterey:       "1e3ef54b27bfdf9ebf6dff73edba9c59fe62f8a32d3c39847b6092a69678feee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "85caec9918586532bbd087cf94e40bf57a5735adffb93ad1f6e172299503f5aa"
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
