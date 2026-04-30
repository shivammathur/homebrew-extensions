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
    sha256 cellar: :any,                 arm64_tahoe:   "fd0771cc7fa922cc6274d96089745466274a7ac4a96bf0988c0d383b83c78abe"
    sha256 cellar: :any,                 arm64_sequoia: "296b3d31ff0ed0044400022f4a875d517395c649ce9af384d25d9e8683952ac0"
    sha256 cellar: :any,                 arm64_sonoma:  "6e5f64221dace2f2c0000cd6fe74a6057da050f615e0a50706203f595343ccb6"
    sha256 cellar: :any,                 sonoma:        "f14e4701bf1513100787ca5162376694226f090516ed7c40a33eb6b2cdd47e12"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1c167707c8ba848bdeb16adf72e32f69fcfe91103434dabe16704940a813f490"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d60ed3965ddec338404f63a93185c67ea40c3a6ee0c3a4050226aef041b2ecec"
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
    Dir["**/*.{c,h}"].each do |f|
      contents = File.read(f)
      next if contents.exclude?("XtOffsetOf") && contents.exclude?("zval_dtor")

      needs_stddef = contents.include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof" if needs_stddef
        s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" if contents.include?("zval_dtor")
        s.sub!(/\A/, "#include <stddef.h>\n") if needs_stddef
      end
    end
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
