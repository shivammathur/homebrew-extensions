# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT72 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_ventura:  "609f97089b87d51fc410ddf5281110697802c8611e231e783c079fba9f993718"
    sha256 arm64_monterey: "4908659850c202bab2b58279a9338b38c82ce580e5c4b403534c86969d35fae0"
    sha256 arm64_big_sur:  "216d68c07e3e01ab27aeeb18b202506ed31456ac23a2a450e9d96a61d32d7896"
    sha256 ventura:        "67cd07d8f7744dc3736cbc5ad0890a10383e0fe9df4f301c7e42d0a78b6fef3d"
    sha256 monterey:       "b7520821e7d2541552c00fe1688ec2473ae077c2fc63bae1843521207883847f"
    sha256 big_sur:        "dd29c100753006a1143eb0c1be7318cbd628ecc0f940c9ec3d60740fc3976b96"
    sha256 x86_64_linux:   "bde06878d9f426452857ec88c705ab66cc56c24b320a80a4cb598ef802385074"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
