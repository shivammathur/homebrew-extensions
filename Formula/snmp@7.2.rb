# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f4457d3e8b14e8fd31f70dde5b19e6799fe71538.tar.gz"
  version "7.2.34"
  sha256 "2beaaef99d934c31390a83e51dd61f981004fca474aa4655573292409ce83ca4"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "15413d4fe3b61160967f14bfda66ffb1c5f081ba9fb7da5a3d64b7e954e7e77d"
    sha256 cellar: :any, arm64_tahoe:       "6f69c71ceb574004211c8c19ca71ba4dd41a72feb2941687c829aa51ea2ef3e1"
    sha256 cellar: :any, arm64_sequoia:     "846b9e249333a061c1cffc85efb6ff38140eadaa7abeb2b3b45af202548d6f8d"
    sha256 cellar: :any, arm64_linux:       "d1f8ae0d56ddf60ffe12f629d70da59b9bbec0a72ea1d1cd51a4580fac8cf0f1"
    sha256 cellar: :any, x86_64_linux:      "7e87477b5390e9d0958c6aa3dc5855a1ea994084e6d5583c14f9ff9ac460e6e4"
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
