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
  revision 2
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "aad6d7a4aec8f71c0881ed3a0ad3445cfa499b25ddc60cdc739da323b99702a4"
    sha256 cellar: :any, arm64_tahoe:       "abb2a03be5d4f8f4b0bf59c86bee4df1c9676752999b5a58defc63c54a41e6ff"
    sha256 cellar: :any, arm64_sequoia:     "17d2384708cb40d91077e1bdbf296ee66fa4eb66f3b9fa3238f828df7d7cd509"
    sha256 cellar: :any, arm64_linux:       "8f580b31001c0c9105e7e641eb561c0f215a75755adb1f6fe2f49e61fb8c5ab0"
    sha256 cellar: :any, x86_64_linux:      "428e19992a568b9b0e69ecda0278611b47900fd95b3dae784c0f6e7ff8a291c9"
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
