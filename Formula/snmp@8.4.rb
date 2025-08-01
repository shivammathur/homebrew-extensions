# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.11.tar.xz"
  sha256 "04cd331380a8683a5c2503938eb51764d48d507c53ad4208d2c82e0eed779a00"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "07fc4c3102a96acf698da53d2ce51bfaf7729d9ac33e74accae8780746c718cc"
    sha256 cellar: :any,                 arm64_sonoma:  "70dd9a91ea1d7d97e65f98a43d872897068fc99017caa6940947a1ea5c8baf10"
    sha256 cellar: :any,                 arm64_ventura: "9546aab3bb2c9af3f979959a736ed27c56b24d94479b46d0de57da33e4357f42"
    sha256 cellar: :any,                 ventura:       "5f064dd35464f36d6df481bafa4fd0d2ebffb5c648dda5844539eeeef83bdf4c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "01c47e2efab11e2418ffe18e57cd50dbf3b0e03fc842dbbe6ea0a26595dd3064"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80b7b974ff1686fcead429bdabe932130aa0fa0b14bb2c3a43fbfe33581308eb"
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
