# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.2.tar.gz"
  sha256 "3659538cd6c3eb55097989f40b6aa172a0e09646b68ee657ace33aa0e4356849"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "329986bba3d4eb699e2caa26e9df372aad0cc61fea3a6ab85151f63a7b243410"
    sha256 arm64_sonoma:  "58db6a971aa3c8d3addc18c785cf21d53080c3b9e8e4a3bcc55395fbfa812c5d"
    sha256 arm64_ventura: "d970b4e6f79e352a642ebae749e92d47cd6078956911b52964db458b8034eb7d"
    sha256 ventura:       "54af07a1e1931b24cd266e792c8d576d266a6a158752eed8e96e996b7d3b659e"
    sha256 x86_64_linux:  "eb910158a07c88a7e0db2a0c7fc52deabed3c08f53bc4ae7b26fd1d1722dd083"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
