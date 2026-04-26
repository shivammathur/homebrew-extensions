# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT86 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/616b6c64ffd3866ed038615494306dd464ab53fc.tar.gz"
  sha256 "5cb6e5857623cb173ad89fa600529e71328361906127604297b6c4ffd1349f88"
  version "1.1.3"
  revision 1
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "be970de03388dbd483464af5b28423b615fc8f8ade44f38d057aa14181183218"
    sha256 cellar: :any,                 arm64_sequoia: "479aa61d3b2b798a2a8b30941e169b18094f77ff3202a92e70e43f50ae22e73b"
    sha256 cellar: :any,                 arm64_sonoma:  "5abd2c4804df014f40e051060b2200020156f6ab5bc6705dacf29a2801cade01"
    sha256 cellar: :any,                 sonoma:        "ca424bfffaeb16675d0b6b869bfdf234ab4d43903618f6555eb8253fe12a203a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "43a9b5063d6ddfc15ca72cdcfa5ec61a0af60a45a31fb34435021d9e681fa41f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16d54531cd7be1779b05af764c80a7c68a77496ac755b87d2af955badc4753f1"
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
    inreplace "zmq.c", "zend_exception_get_default()", "zend_ce_exception"
    inreplace %w[zmq.c zmq_pollset.c], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "zmq_device.c", "zval_is_true", "zend_is_true"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
