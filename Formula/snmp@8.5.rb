# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3b23de31db969c3c12060ff7c5ba363f65de6669.tar.gz?commit=3b23de31db969c3c12060ff7c5ba363f65de6669"
  version "8.5.0"
  sha256 "3b04abd3994da6e9f4b7ffc40770595f6e0908d88bd4009d54d1a43e0d7db9e4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "ef69341c047cac55e54b176d526b3a127c4d38c1f8db60ea3920c8633b9cb979"
    sha256 cellar: :any,                 arm64_sonoma:  "112c5143d9975698b3903e9a79ad3b6fabc20542f76ae765c05780d96e03ed68"
    sha256 cellar: :any,                 arm64_ventura: "ab17de9d317cfff11d415cc07853bbb96beef2fa981a8096407a026cad99fdae"
    sha256 cellar: :any,                 ventura:       "2346382a53849c496078a4fa95d887e6ed617dd3247ead3ffd6bfdc2fce38075"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cedba42d430484bdc9510da8a3fc3bdca37eac2f35d2f7bfef78d86996690e22"
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
