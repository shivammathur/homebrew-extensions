# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/db545767e57d74e7ec0e1817a208d0d44e0932e6.tar.gz?commit=db545767e57d74e7ec0e1817a208d0d44e0932e6"
  version "8.4.0"
  sha256 "7f791c3bff47dd3e9254b741444fbdb29085220e20466a2ee61ae9e87c87a3c6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 60
    sha256 cellar: :any,                 arm64_sequoia:  "d6a09c2ab2680eadfa5f395f9e67bb3a129c12b6a0ba7e077071cc9897d5b886"
    sha256 cellar: :any,                 arm64_sonoma:   "36f937ed0e43ca06f4881912e8d4af4ab33a2383179ca807171a52a8d4a8a2fa"
    sha256 cellar: :any,                 arm64_ventura:  "80ddefa615e525d813a5f53329a2b24989aaed519484d0a30a9e7c56633f3f72"
    sha256 cellar: :any,                 arm64_monterey: "657e5609829cc6f58a06a34b4ae8c3c5a60348e30fc85cdadfa97dff6cfd3210"
    sha256 cellar: :any,                 ventura:        "8343e655e8522b074a8ea63e0737511e158dcedbda65a3d8d2a878bf96e4b4f0"
    sha256 cellar: :any,                 monterey:       "70e47d41cea1625980400286c8ebe1afe8cf40b8c056a88fbc59a0163f355145"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5771944053db09165d3215d6a2348d37ccb5f00bfe5f7e35dd4921637512430"
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
