# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "dc0e9d2d4759483e5db996b695d9a907c859fd627c63ee2f1f68e8046e6cc279"
    sha256 cellar: :any, arm64_sequoia: "6ed7b086a1b6d57e58e8aa82ea84ac4686c7c0219b8faf6392d9cb157ade9538"
    sha256 cellar: :any, arm64_sonoma:  "b452a75ca2878899666f726f79521f0007eca56f4fd588483904c9ac894a6598"
    sha256 cellar: :any, sonoma:        "44845bc98f051831dc20f14ec5eb008a074c187102540f9c20a25acfd9e4a7e1"
    sha256 cellar: :any, arm64_linux:   "64d59a824081fe959edd70298f783e107e95b18af223f9cc08ca97a64cd9027d"
    sha256 cellar: :any, x86_64_linux:  "a6f815d2e1ebec030898c74db338909a57e19f05e2741e09b4629a14fa51d8d8"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
