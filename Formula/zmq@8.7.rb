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
  revision 2
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "32890fee85668522e25df2086823adc83a198b7fe73c5297107ec439dfedba32"
    sha256 cellar: :any, arm64_tahoe:       "3108886ab6bf19ec0b32744603a0174b3e6d408cac1dd328fa26ee438918843d"
    sha256 cellar: :any, arm64_sequoia:     "38f6b9510aba01ea05c20f28638167b361c35f52b1c825899d3c40eb76a7e0d3"
    sha256 cellar: :any, arm64_linux:       "250a9f75bbd11f0a6f94ea668572e1c85de4789a9236faffc72eb0bf4113c070"
    sha256 cellar: :any, x86_64_linux:      "53668a35360a5dcda55ae33189cff0ff4ecddb99c0477f4f4908ee05334cc8a8"
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
