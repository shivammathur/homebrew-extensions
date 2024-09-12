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
    rebuild 59
    sha256 cellar: :any,                 arm64_sonoma:   "87204a2597a498a773f06c39bf80096d6aee19bd09499fc60875d7a97501a26d"
    sha256 cellar: :any,                 arm64_ventura:  "34815c6817e3e4fb4b555bbdb3eb0da7e59be61f17deae882165a5b9223bfb3b"
    sha256 cellar: :any,                 arm64_monterey: "d5fff095f4e7899361bff40d81fc938d743bef75835d10aabf76403a5496bcc6"
    sha256 cellar: :any,                 ventura:        "b6b2785c4666c1a3a39836b21ca6b4ae3d050f2e299b4d8d7112bb4c6bad86dd"
    sha256 cellar: :any,                 monterey:       "2f25bc9de7cecfc60f4b0c7dacd7ca7dba1042d1db138ad86ac542a173075cd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "088a38a66af22bc39fdccd77586045f2611cd9a23142ae4d2ed9c78fb903b8d8"
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
