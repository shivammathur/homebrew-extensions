# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fc09f4b2bc36b40a79f3ee0c2c557693ba57f836.tar.gz?commit=fc09f4b2bc36b40a79f3ee0c2c557693ba57f836"
  version "8.4.0"
  sha256 "9a499db00c16e02c82b20fb625413281fb4427094c2824b1316e73fbea7bef83"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 49
    sha256 cellar: :any,                 arm64_sonoma:   "741080056ee00806c51284ba32641ec70da02666cc9e5526c130b6fba2186c6a"
    sha256 cellar: :any,                 arm64_ventura:  "4d4e15800e1856899d58674abe39ad2fd399cfbf07f3c040251faadd960c3f64"
    sha256 cellar: :any,                 arm64_monterey: "d41910b878db60c269ef4ef4e8c7139bcff7092075ec6e36eccc510d956ea436"
    sha256 cellar: :any,                 ventura:        "dcccfb3f774fb54663ad8da894fa8ef6f482eb083d651a9423888d3387980f44"
    sha256 cellar: :any,                 monterey:       "145e230b95b9ea609c356e86864a6318d60e23b4aab2405d54551f1ecdf41370"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69636a0519addf7aeb6dfe109bcd316d2de60cd3f42f9522484efe06ad39a8ea"
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
