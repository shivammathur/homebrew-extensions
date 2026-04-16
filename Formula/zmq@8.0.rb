# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "74655479e2122dbb07e41c6379eb9dafb749141738a351c24cd1d6512cddf449"
    sha256 cellar: :any,                 arm64_sequoia: "aec735986cb14f64e6f993672a4b979bce4f853b5dc6f822d71e56d4466475ed"
    sha256 cellar: :any,                 arm64_sonoma:  "10aaec568a8ae567b5f5f120610ab315aeea633f9ea4471b045d6b7cd0340352"
    sha256 cellar: :any,                 sonoma:        "337ab242f91ed7a687cf4c563a378bcfa0b43962368e09e740e6a8e2f91049ff"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e27b56061d930d9b798814528f54cd4a654759423b75e84d74003f560e95a37a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b54addb822891cfd38e2868755e8658b27347bbe41b4631aa05958f88c4ea801"
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
