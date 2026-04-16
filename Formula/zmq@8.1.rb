# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT81 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/616b6c64ffd3866ed038615494306dd464ab53fc.tar.gz"
  sha256 "5cb6e5857623cb173ad89fa600529e71328361906127604297b6c4ffd1349f88"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_tahoe:   "46c7d2c0169d5b93dbaa2a4fd7004cd66aee904909ea223b3bfd25d814d1be34"
    sha256 cellar: :any,                 arm64_sequoia: "e42b4ee60d55d915ed469f136e8921629f48189040bffac17f96c2a740d95c98"
    sha256 cellar: :any,                 arm64_sonoma:  "026872a652e24ec5ca8db9a1f20ff76703040b71589c7d2afe3461480c3ac6a8"
    sha256 cellar: :any,                 sonoma:        "9b1842352e2c7d70455d358153993cb02eb9824496165dd0e5a15e4849b7f41e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c54c80495cb2058f9a385d42154a7afcb3b6280a50081b748f4013cccfee2de8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "795f6666d1620f17000746b1f134edbcdad3046387ffd84c1c6abe912b07007b"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    args = %W[
      prefix=#{prefix}
    ]
    on_macos do
      args << "--with-czmq=#{Formula["czmq"].opt_prefix}"
    end
    inreplace "package.xml", "@PACKAGE_VERSION@", version.to_s
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version.to_s
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version.to_s
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
