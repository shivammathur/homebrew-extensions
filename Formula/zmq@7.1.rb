# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ca7bb87139cae4f998172021c3b8ecbf2a137dd5d497a6dd228b5e1c59aaf02b"
    sha256 cellar: :any,                 arm64_sequoia: "e747c5abe7f0b8b811f51b2c35ec7e2eb36910513181d2b9aa8c0f1879970adb"
    sha256 cellar: :any,                 arm64_sonoma:  "4ff558e25a061dd505bf18e902f1c4a32794a9075805292e2811b5272a1292f0"
    sha256 cellar: :any,                 sonoma:        "6b34c9632e9ae92597c958f42f9f4dce535b0ea69af5d20e940b6b57f4980a16"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "72b4cc0ab60698c8c569f4910838ba57d722d8a679f4a8b7d8fddd52097e3821"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "780038adde570663379774fbe451a7ef89ac42722fd375490cac0d4192cfab39"
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
