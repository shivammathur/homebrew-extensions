# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6c44436630a8d8f82dba84314c50df7ac08c7534.tar.gz"
  version "7.4.33"
  sha256 "a1a7e475baf81b182bb87f5d295224e9261d09de84d35e59b9ad29926920d0e2"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "62b8878fbe3a7ef73632e74605d336ddb5ee4ef2f0d5ef399bb05a6d0e39f6dc"
    sha256 cellar: :any, arm64_tahoe:       "36449ca9f0d74d8102125e236dd8de3877a139a20991cd72ffd92e7ef7277e1f"
    sha256 cellar: :any, arm64_sequoia:     "e1f8dee221d80d0dbd103ee90832a64dea1c0427605a34123e57a7224012a68d"
    sha256 cellar: :any, arm64_linux:       "12b6075041f0df1195fa20728556c971367b1457981c76fc358911123d593e82"
    sha256 cellar: :any, x86_64_linux:      "af797f61084acf6183dca6b49e55cd6e93a2ead30e20f74c87f4036a4a14d562"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
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
