# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "0f2f0cca104c9bb175bed7855b5cd4e0b81dab54408d37bd1581cf9cb345b114"
    sha256 cellar: :any, arm64_tahoe:       "5ee9b08b92a861cb871d09eda456f6abf7d0e667c04517eb6e0671040fe5e754"
    sha256 cellar: :any, arm64_sequoia:     "bd43b82528b4ef8b726c6b9f64597be0cce1c1dfb44734f3ea2622efd55ad1c8"
    sha256 cellar: :any, arm64_linux:       "1ae38b47937c47a1fba3fae16393fbbfa3e9f48b717367e87a66df68aba4852c"
    sha256 cellar: :any, x86_64_linux:      "fd0551e1a6d587e0c2a830d99ed7cc437ca3a2946f9043161fb04171824b28bc"
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
      args << "--with-czmq=#{Utils::Path.formula_opt_prefix("czmq")}"
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
