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
    sha256 cellar: :any,                 arm64_tahoe:   "dc24876c48b03fa9a5175c9b0cb4c653e1cfd5f38240c0515086d735dbe2f2ef"
    sha256 cellar: :any,                 arm64_sequoia: "3636ceaff2d87d4a9b5f50377c2fab805fee2d92ff14b13f061e2cbc3e5758d7"
    sha256 cellar: :any,                 arm64_sonoma:  "bfbeb7bda01ed2d87c56f41fb9e021bc5063787ad12274ee0ca31b6cd683f934"
    sha256 cellar: :any,                 sonoma:        "95e35e75872cae46f0e520f599f7383dc3700a70d63cf23e5f106fa05f4a5b08"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "910a9a94c9f288d734601bb44f92c8db98e2085ccda857d36ef1c9c9bdc5a71f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f42d52a93c657ac9d3795ae7de7ed51b16742c9282eaa06633e3dbb87cbfaf47"
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
