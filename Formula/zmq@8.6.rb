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
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "749caf49951d44a0adf7ec3af87a6905157b4612a8cd6df6556357d2319899d7"
    sha256 cellar: :any,                 arm64_sequoia: "ab401a643667e0f216bb1c2f3aad1527b413c72b3d213bd7270b67246b0ee59b"
    sha256 cellar: :any,                 arm64_sonoma:  "d1a127515151ec35b48a0d733012df6b012fd5b3b49f51afcc9c1c0d7bce34d7"
    sha256 cellar: :any,                 sonoma:        "6630df95543aaaaf5f120dc41e206cee868a192109f1356ed7496b87f4b3dff2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "02663337b163422de450ab5e0abeb53915df244462cd903a85e464eca3a8bc6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b098ddb56c6ddd34febcaa2984e04f29960421ccdc53f0693e0c41fdc992486c"
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
    inreplace %w[php5/zmq.c php5/zmq_pollset.c zmq.c zmq_pollset.c], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "zmq_device.c", "zval_is_true", "zend_is_true"
    inreplace %w[zmq.c zmq_object_access.c], "XtOffsetOf", "offsetof"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
