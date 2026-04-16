# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "008be2b3181c1354d9b4e69afe2a3633a0e2d1997f0478d916e83f1e73497800"
    sha256 cellar: :any,                 arm64_sequoia: "d90764abc8a43201630b7f33cfeab506550add548f214a31333d8b85cbdb54f8"
    sha256 cellar: :any,                 arm64_sonoma:  "2fdaa72d374b4e11f69ed8500f1097d88341c0890277ce9b1ca681e976f29362"
    sha256 cellar: :any,                 sonoma:        "3872f967bbe2b99b05572b289fc8a4b157ce679b824f7b7b3813bc787cb622d3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b045d131cf46a1320840a332b80e5c71d642636fec63cba6b3994d0638a36989"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b48024eadd94ddb199d42857e71e6b174fd4050930b7a8ab8b288bc8bda115d"
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
