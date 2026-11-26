# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19db02dfc0c93c3dcddf34df282ee6db125203df.tar.gz"
  version "7.1.33"
  sha256 "053573e6077d61663bb95d2130b661efa52c5b10f9379243fcbdac9ce01b1e99"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "e24608f6544585a044709df788be10df0f8787c759cca63de9ba40a777d48312"
    sha256 cellar: :any, arm64_golden_gate: "67583a798603a894c4fada0ecdec2d0ecaf1ce7905d5b0970e86854dc8c82344"
    sha256 cellar: :any, arm64_tahoe:       "9a34a53e4ef4d2af06a0dcaa68c95e1758a5ad5b38a67c55d7ab7d45e1a3f417"
    sha256 cellar: :any, arm64_sequoia:     "5a602c551970fc94b5ced19e62b4486b2631eb6df03543103adb9df0c90e0bb5"
    sha256 cellar: :any, arm64_linux:       "05ea9b876fbf4b1257dd5e5fb46b5af3ca98419b30262607b558a75f6178eb7c"
    sha256 cellar: :any, x86_64_linux:      "f0243b4fe8a5d3e0404c7e0381bb8e71399eb7172ce0716fb97261ce8b2ac195"
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
