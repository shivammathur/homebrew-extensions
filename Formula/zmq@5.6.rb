# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT56 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "74dffc9b8bd015c08b623fbbe3c5d91cb2e22289deef917b8f1db15e07be6069"
    sha256 cellar: :any,                 arm64_sequoia: "2077fa3c778f55a9a1f51ef23fa9e816bb340dcb22866a01ef17b06ffaf08020"
    sha256 cellar: :any,                 arm64_sonoma:  "96f01a71151827af90cf73488256f7f80913e9db97a78c85e0f9cf37857a201f"
    sha256 cellar: :any,                 sonoma:        "ae8f0526b1255a00f3a7c293959ae9cced0169d608c88249993d0f841b198840"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "060b4b11d5434443b443a48b2c15d90905c6d63fbbf4ca476d6e49197d492eaa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dd03a16d0c357726183cd88a70425955c0b44337615085de579d2a0c6d7a91e6"
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
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
