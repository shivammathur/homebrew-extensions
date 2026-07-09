# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/418ed8a42fc1ff3f1f434873c4d453713d4164ea.tar.gz"
  version "7.2.34"
  sha256 "8b8104c40d0e453088f8fe703a0ead74ffdb5a4d0deb9b102864aa206bef5d2b"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "cf3533636518c17cd67e28ab9d8172f751d00c9d4af303b0c490a92c18aeb4e8"
    sha256 cellar: :any, arm64_sequoia: "bdba42f0b56e03c22397818760acf3dd53e6bc778fe6534791b38ac12e3ede87"
    sha256 cellar: :any, arm64_sonoma:  "13d00174aa4d4b4e12163d182ec6d37f7b050bdee5a9fc6ddf9352500079c04a"
    sha256 cellar: :any, sonoma:        "0eac60127c42d9b487200d6ebd2e7adaf0ed56683e120cdb95a3ab497653f10a"
    sha256 cellar: :any, arm64_linux:   "19cab8b52f4889314bf36aaecf154c0ee6604b1b860be7c1efdd8029aa7b1c98"
    sha256 cellar: :any, x86_64_linux:  "6513f7c2cb02e6a6cfdfcdc8e357c16bf0eb36648b4c9beb71ec33ea975a4c61"
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
