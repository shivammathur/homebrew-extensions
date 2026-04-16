# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ed91186813270004ef992ac86922ddf68788bad1afe5e7ab506e1762d8d16638"
    sha256 cellar: :any,                 arm64_sequoia: "dc13d065d3a64b3521679ee98e00ef0913b00799e1f6666b048c6b8ef0dfd1e7"
    sha256 cellar: :any,                 arm64_sonoma:  "a502576fa31479f059731c40304f7c882107a1e291a6462f1a7d0fc62bf78d63"
    sha256 cellar: :any,                 sonoma:        "5f1e2380eaf82ce59fb9b87dde3f3ed6a57b5f72c6e53023a34f9df0e0f55a1f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0a04c8827b74ecfee7078de94c5c53646d76d2df4a2beb74b336260abc259af7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0de651f524480d89999a40f04d2ab4f964eb8260c97f2fe87e68ed9fcdfe3dff"
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
