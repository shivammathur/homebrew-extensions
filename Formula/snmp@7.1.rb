# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "b788516771a2a1617a505343b2dc12bbe8fbe3bbce372c2f53115a918b2fdd19"
    sha256 cellar: :any, arm64_tahoe:       "eb54912bece4c13d27bb38278901cf1f2cb6f9c03bc93d5221fee3f1204e44be"
    sha256 cellar: :any, arm64_sequoia:     "d9c5e49c25c3dfb18dd8c6d340aae115e34a42c5b7237e17569e33a6907764e3"
    sha256 cellar: :any, arm64_linux:       "e3beda2e9dc38fc59232a5fcbbd8f1e6eef916553479fe198e9978c463dcaa99"
    sha256 cellar: :any, x86_64_linux:      "9447453019685863d554a7e30672957ecb5c78fb6827d8b77336c1b9267fae66"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
