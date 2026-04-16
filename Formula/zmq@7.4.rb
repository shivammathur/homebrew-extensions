# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "7f423d7b51d73f8c60b3ba61ebec88af269bc9dfb4f38c25b8b9c507327fb487"
    sha256 cellar: :any,                 arm64_sequoia: "8308364a43f7bff3bfaa2c7d3e6f34dd4e9a399c8fa82e7f4374ab54c3f2aba0"
    sha256 cellar: :any,                 arm64_sonoma:  "260e8b8fc70323904837a8ecf76f0deb468750e1ce4515052f76cd944c4c522a"
    sha256 cellar: :any,                 sonoma:        "fbdc55ef8a85d8456499d0c85d1bdc36637d9b21efbbee59511e4045855644cf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f042a431c0065f3478a6dc993f35a6d814c66765949526d0eca105138c4e4108"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc39567d560d14bd535842f19e45237744553782cefa4f9842d7158da0b0c55b"
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
